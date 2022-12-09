import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lat_long_collector/app/view/block/barrel.dart';

import '../../../../models/form_component.dart';
import '../../../form/bloc/bloc.dart';
import '../../../template/barrel.dart';
import '../../../template/item_list/base_widget.dart';
import '../view_model/bloc.dart';

class CandidateListWidget extends ItemListTemplateBaseWidget with MixInLogger {
  CandidateListWidget({
    required this.component,
  });

  final FormComponent component;

  @override
  Widget title(BuildContext context, AbstractFormzBlocState state) {
    state as CandidateListBlockState;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getFormTitle(component),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  bool buildWhen(AbstractFormzBlocState prev, AbstractFormzBlocState current) {
    prev as CandidateListBlockState;
    current as CandidateListBlockState;

    return prev.addresses != current.addresses;
  }

  @override
  void onFetchData(BuildContext context, AbstractFormzBlocState state) {
    state as CandidateListBlockState;

    if (state.addresses.isNotEmpty) {
      final formBloc = context.read<DashboardBloc>();
      final textBloc = formBloc.blocManager.pullBloc("text");
      final text = textBloc.state.cube.value;
      formBloc.blocManager.pullBloc("candidate_list").add(CandidateSearchAdditionalRequested(text));
    }
  }

  @override
  int itemCount(AbstractFormzBlocState state) {
    state as CandidateListBlockState;

    return state.addresses.length;
  }

  @override
  Widget itemBuilder(BuildContext context, AbstractFormzBlocState state, int index) {
    state as CandidateListBlockState;

    final address = state.addresses[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // LEARN: Need to hide border
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey[300],
        // LEARN: Need to hide border
        child: ListTile(
          selectedColor: Colors.blue,
          title: Text(address.name),
          subtitle: Column(
            children: [
              Text(address.address),
              const SizedBox(height: 4.0),
            ],
          ),
          onTap: () {
            context.read<CandidateListBlockBloc>().add(CandidateSearchSelected(address, index));
            final formBloc = context.read<DashboardBloc>();
            final mapBloc = formBloc.blocManager.pullBloc("location_light") as LocationLightBlockBloc;
            mapBloc.add(LocationLightUpdated(address));
          },
        ),
      ),
    );
  }

  @override
  double height(BuildContext context) {
    return MediaQuery.of(context).size.height / 1.7;
  }
}
