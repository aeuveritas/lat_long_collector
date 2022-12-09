import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/abstract_bloc_state.dart';
import 'base_widget.dart';

class TextBoxTemplateDynamic<T1 extends TextBoxTemplateBaseWidget, T2 extends StateStreamable<T3>,
    T3 extends AbstractFormzBlocState> extends StatelessWidget {
  const TextBoxTemplateDynamic(this.widget, {Key? key}) : super(key: key);

  final T1 widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T2, T3>(
      listener: (context, state) => widget.listener(context, state),
      buildWhen: (prev, current) => widget.buildWhen(prev, current),
      builder: (context, state) {
        return Column(
          children: [
            widget.title(context, state),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget.readyOnly(),
                    controller: widget.bindTextEditingController,
                    key: Key(widget.bindTextFormFieldKeyString),
                    onChanged: (name) {
                      widget.onChanged(context, name);
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: widget.bindHintText,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      errorText: widget.errorText(state),
                      isDense: true,
                    ),
                    keyboardType: widget.bindKeyboardType,
                    inputFormatters: widget.bindInputFormatters,
                    maxLines: null,
                  ),
                ),
                if (widget.bindPostText != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(widget.bindPostText),
                  )
              ],
            ),
          ],
        );
      },
    );
  }
}
