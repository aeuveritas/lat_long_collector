import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/form_component.dart';
import '../../../template/location_light/base_widget.dart';
import '../../../template/models/abstract_bloc_state.dart';
import '../view_model/bloc.dart';

class LocationLightWidget extends LocationLightBaseWidget {
  const LocationLightWidget(this.component) : super();

  final FormComponent component;

  @override
  bool buildWhen(AbstractFormzBlocState prev, AbstractFormzBlocState current) {
    prev as LocationLightBlockState;
    current as LocationLightBlockState;

    return prev.locationInfo != current.locationInfo;
  }

  @override
  Widget map(BuildContext context, AbstractFormzBlocState state) {
    state as LocationLightBlockState;

    if (state.locationInfo.name == "") {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // LEARN: Need to hide border
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.blue[400],
        // LEARN: Need to hide border
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              state.locationInfo.name,
              style: const TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ),
          subtitle: Column(
            children: [
              Text(
                state.locationInfo.address,
                style: const TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              const SizedBox(height: 4.0),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget title(BuildContext context, AbstractFormzBlocState state) {
    state as LocationLightBlockState;

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
}
