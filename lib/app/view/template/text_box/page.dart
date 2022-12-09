import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/abstract_bloc_state.dart';
import 'base_widget.dart';
import 'dynamic.dart';

// TODO: change form to template in other templates
class TextBoxTemplatePage<T1 extends TextBoxTemplateBaseWidget, T2 extends StateStreamable<T3>,
    T3 extends AbstractFormzBlocState, T4 extends StateStreamableSource<T3>> extends StatelessWidget {
  const TextBoxTemplatePage(this.widget, this.bloc, {Key? key}) : super(key: key);

  final T1 widget;
  final T4 bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T4>.value(
      value: bloc,
      child: TextBoxTemplateDynamic<T1, T2, T3>(
        widget,
      ),
    );
  }
}
