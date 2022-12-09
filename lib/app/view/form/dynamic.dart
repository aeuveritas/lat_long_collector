import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';
import 'package:lat_long_collector/app/models/form_component.dart';

import '../../consts/app_texts.dart';
import '../block/barrel.dart';
import '../template/barrel.dart';
import 'bloc/bloc.dart';

class DashboardDynamic extends StatelessWidget {
  const DashboardDynamic(this.textEditingController, {Key? key}) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status.isPure) {
          return const Center(child: CircularProgressIndicator());
        }

        final dashboardBloc = context.read<DashboardBloc>();
        final candidateListBloc = dashboardBloc.blocManager.pullBloc("candidate_list") as CandidateListBlockBloc;
        final destinationListBloc = dashboardBloc.blocManager.pullBloc("destination_list") as DestinationListBlockBloc;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Lat Long Collector"),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextBoxTemplatePage<TextBoxWidget, TextBoxBlockBloc, TextBoxBlockState,
                                TextBoxBlockBloc>(
                              TextBoxWidget(
                                component: FormComponent.dashboardTextBox,
                                hintText: "",
                                textEditingController: textEditingController,
                                textFormFieldKeyString: '',
                              ),
                              dashboardBloc.blocManager.pullBloc("text") as TextBoxBlockBloc,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              child: const Text(SEARCH),
                              onPressed: () {
                                final text = dashboardBloc.blocManager.pullData("text") as String;
                                candidateListBloc.add(CandidateSearchFirstRequested(text));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.status.isSubmissionInProgress)
                      const Expanded(
                        flex: 8,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (!state.status.isSubmissionInProgress)
                      Expanded(
                        flex: 8,
                        child: ItemListTemplatePage<CandidateListWidget, CandidateListBlockBloc,
                            CandidateListBlockState, CandidateListBlockBloc>(
                          CandidateListWidget(
                            component: FormComponent.dashboardCandidateList,
                          ),
                          dashboardBloc.blocManager.pullBloc("candidate_list") as CandidateListBlockBloc,
                        ),
                      ),
                    if (state.status.isSubmissionInProgress)
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (!state.status.isSubmissionInProgress)
                      Expanded(
                        flex: 2,
                        child: LocationLightTemplatePage<LocationLightWidget, LocationLightBlockBloc,
                            LocationLightBlockState, LocationLightBlockBloc>(
                          const LocationLightWidget(FormComponent.dashboardMap),
                          dashboardBloc.blocManager.pullBloc("location_light") as LocationLightBlockBloc,
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 100, child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                final formBloc = context.read<DashboardBloc>();
                                final location = formBloc.blocManager.pullData("location_light") as LocationInfo;
                                destinationListBloc.add(DestinationListAdded(location));
                              },
                              child: const Text("Add"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    if (state.status.isSubmissionInProgress)
                      const Expanded(
                        flex: 10,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (!state.status.isSubmissionInProgress)
                      Expanded(
                        flex: 10,
                        child: ItemListTemplatePage<DestinationListWidget, DestinationListBlockBloc,
                            DestinationListBlockState, DestinationListBlockBloc>(
                          DestinationListWidget(
                            component: FormComponent.dashboardDestinationList,
                          ),
                          dashboardBloc.blocManager.pullBloc("destination_list") as DestinationListBlockBloc,
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 100, child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                String? outputFile = await FilePicker.platform
                                    .saveFile(dialogTitle: 'Save Your File to desired location', fileName: "test.yaml");

                                if (outputFile != null) {
                                  destinationListBloc.add(DestinationListSaved(outputFile));
                                }
                              },
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
