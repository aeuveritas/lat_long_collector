import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/abstract_bloc_state.dart';
import 'base_widget.dart';

class LocationLightTemplateDynamic<T1 extends LocationLightBaseWidget, T2 extends StateStreamable<T3>,
    T3 extends AbstractFormzBlocState> extends StatelessWidget {
  const LocationLightTemplateDynamic(this.widget, {Key? key}) : super(key: key);

  final T1 widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T2, T3>(
      buildWhen: (prev, current) => widget.buildWhen(prev, current),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widget.title(context, state),
              widget.map(context, state),
            ],
          ),
        );
      },
    );
  }
}
