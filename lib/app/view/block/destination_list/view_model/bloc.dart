import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';
import 'package:yaml_writer/yaml_writer.dart';

import '../../../../models/form_component.dart';
import '../../../template/models/barrel.dart';

part 'event.dart';
part 'state.dart';

class DestinationListBlockBloc extends Bloc<DestinationListBlockEvent, DestinationListBlockState> with MixInLogger {
  DestinationListBlockBloc({
    required this.updateStreamController,
    required this.component,
  }) : super(DestinationListBlockState()) {
    on<DestinationListAdded>(_onDestinationListAdded);
    on<DestinationListRemoved>(_onDestinationListRemoved);
    on<DestinationListSaved>(_onDestinationListSaved);
  }

  final StreamController<FormComponent> updateStreamController;
  final FormComponent component;

  void _onDestinationListAdded(
    DestinationListAdded event,
    Emitter<DestinationListBlockState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    final currentAddresses = state.addresses.toList();
    currentAddresses.add(event.location);
    emit(state.copyWith(
      addresses: currentAddresses,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onDestinationListRemoved(
    DestinationListRemoved event,
    Emitter<DestinationListBlockState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    final currentAddresses = state.addresses.toList();
    currentAddresses.removeAt(event.index);
    emit(state.copyWith(
      addresses: currentAddresses,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onDestinationListSaved(
    DestinationListSaved event,
    Emitter<DestinationListBlockState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    File savedFile = File(event.outputFile);

    final locationList = state.addresses
        .map((e) => {
              "name": e.name,
              "lat": e.latitude,
              "long": e.longitude,
            })
        .toList();

    Map<String, List> writeData = {"destinations": locationList};

    final yamlWriter = YAMLWriter();

    final writeYaml = yamlWriter.write(writeData);
    await savedFile.writeAsString(writeYaml);

    emit(state.copyWith(
      addresses: [],
      status: FormzStatus.submissionSuccess,
    ));
  }
}
