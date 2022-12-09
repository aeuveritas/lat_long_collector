import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/abstract_bloc_state.dart';
import 'base_widget.dart';
import 'dynamic.dart';

class LocationLightTemplatePage<T1 extends LocationLightBaseWidget, T2 extends StateStreamable<T3>,
    T3 extends AbstractFormzBlocState, T4 extends StateStreamableSource<T3>> extends StatelessWidget {
  const LocationLightTemplatePage(this.widget, this.bloc, {Key? key}) : super(key: key);

  final T1 widget;
  final T4 bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T4>.value(
      value: bloc,
      child: LocationLightTemplateDynamic<T1, T2, T3>(widget),
    );
  }
}
