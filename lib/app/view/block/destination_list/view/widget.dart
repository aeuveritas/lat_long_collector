import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lat_long_collector/app/view/block/barrel.dart';

import '../../../../models/form_component.dart';
import '../../../template/barrel.dart';
import '../../../template/item_list/base_widget.dart';

class DestinationListWidget extends ItemListTemplateBaseWidget with MixInLogger {
  DestinationListWidget({
    required this.component,
  });

  final FormComponent component;

  @override
  Widget title(BuildContext context, AbstractFormzBlocState state) {
    state as DestinationListBlockState;

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
    prev as DestinationListBlockState;
    current as DestinationListBlockState;

    return prev.addresses != current.addresses;
  }

  @override
  void onFetchData(BuildContext context, AbstractFormzBlocState state) {
    state as DestinationListBlockState;
  }

  @override
  int itemCount(AbstractFormzBlocState state) {
    state as DestinationListBlockState;

    return state.addresses.length;
  }

  @override
  Widget itemBuilder(BuildContext context, AbstractFormzBlocState state, int index) {
    state as DestinationListBlockState;

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
          trailing: GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () {
              context.read<DestinationListBlockBloc>().add(DestinationListRemoved(index));
            },
          ),
        ),
      ),
    );
  }

  @override
  double height(BuildContext context) {
    return MediaQuery.of(context).size.height / 1.22;
  }
}
