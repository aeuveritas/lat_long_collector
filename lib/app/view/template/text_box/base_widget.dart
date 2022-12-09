import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/abstract_bloc_state.dart';

abstract class TextBoxTemplateBaseWidget {
  const TextBoxTemplateBaseWidget();

  Widget title(BuildContext context, AbstractFormzBlocState state);
  bool buildWhen(AbstractFormzBlocState prev, AbstractFormzBlocState current);
  bool readyOnly();
  String? errorText(AbstractFormzBlocState state);
  void listener(BuildContext context, AbstractFormzBlocState state);
  void onChanged(BuildContext context, String name);

  TextEditingController get bindTextEditingController;
  String get bindTextFormFieldKeyString;
  String get bindHintText;
  String get bindPostText;
  TextInputType get bindKeyboardType;
  List<TextInputFormatter>? get bindInputFormatters;
}
