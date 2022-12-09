import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/form_component.dart';
import '../../../template/barrel.dart';
import '../../../template/text_box/base_widget.dart';
import '../view_model/bloc.dart';

class TextBoxWidget extends TextBoxTemplateBaseWidget with MixInLogger {
  TextBoxWidget({
    required this.component,
    required this.textEditingController,
    required this.hintText,
    required this.textFormFieldKeyString,
    this.postText = "",
    this.keyboardType = TextInputType.text,
    this.inputFormatters = null,
  });

  final FormComponent component;
  final TextEditingController textEditingController;

  final String hintText;
  final String postText;

  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final String textFormFieldKeyString;

  @override
  Widget title(BuildContext context, AbstractFormzBlocState state) {
    state as TextBoxBlockState;

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
    prev as TextBoxBlockState;
    current as TextBoxBlockState;

    return prev.cube.value != current.cube.value;
  }

  @override
  bool readyOnly() {
    return false;
  }

  @override
  String? errorText(AbstractFormzBlocState state) {
    state as TextBoxBlockState;
    return state.cube.errorMessage();
  }

  @override
  void onChanged(BuildContext context, String text) {
    final bloc = context.read<TextBoxBlockBloc>();
    bloc.add(TextBoxBlockChanged(text, false));
  }

  @override
  void listener(BuildContext context, AbstractFormzBlocState state) {
    state as TextBoxBlockState;

    if (state.textEditingControllerUpdateRequired) {
      textEditingController.text = state.cube.value;
      context.read<TextBoxBlockBloc>().add(const TextBoxBlockTextEditingControllerUpdated());
    }
  }

  @override
  TextEditingController get bindTextEditingController => textEditingController;

  @override
  String get bindHintText => hintText;

  @override
  String get bindTextFormFieldKeyString => textFormFieldKeyString;

  @override
  String get bindPostText => postText;

  @override
  TextInputType get bindKeyboardType => keyboardType;

  @override
  List<TextInputFormatter>? get bindInputFormatters => inputFormatters;
}
