import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../models/form_component.dart';
import '../../../template/models/barrel.dart';
import '../model/cube.dart';

part 'event.dart';
part 'state.dart';

class TextBoxBlockBloc extends Bloc<TextBoxBlockEvent, TextBoxBlockState> with MixInLogger {
  TextBoxBlockBloc(this.updateStreamController, this.component, this.minLength, this.maxLength,
      [bool pureAllowed = false])
      : super(TextBoxBlockState(cube: TextBoxCube.pure(minLength, maxLength), pureAllowed: pureAllowed)) {
    on<TextBoxBlockChanged>(_onShopNameBlockChanged);
    on<TextBoxBlockTextEditingControllerUpdated>(_onShopNameBlockTextEditingControllerUpdated);
  }

  final StreamController<FormComponent> updateStreamController;
  final FormComponent component;

  final int minLength;
  final int maxLength;

  void _onShopNameBlockChanged(
    TextBoxBlockChanged event,
    Emitter<TextBoxBlockState> emit,
  ) async {
    if (state.status.isSubmissionInProgress) {
      return;
    }

    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    final cube = TextBoxCube.dirty(event.text, minLength, maxLength);
    emit(state.copyWith(
      cube: cube,
      status: Formz.validate([cube]),
      textEditingControllerUpdateRequired: event.textEditingControllerUpdateRequired,
    ));
    updateStreamController.add(component);
  }

  void _onShopNameBlockTextEditingControllerUpdated(
    TextBoxBlockTextEditingControllerUpdated event,
    Emitter<TextBoxBlockState> emit,
  ) async {
    emit(state.copyWith(
      textEditingControllerUpdateRequired: false,
    ));
    updateStreamController.add(component);
  }
}
