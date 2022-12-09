import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../models/abstract_bloc_state.dart';
import 'base_widget.dart';

class ItemListTemplateDynamic<T1 extends ItemListTemplateBaseWidget, T2 extends StateStreamable<T3>,
    T3 extends AbstractFormzBlocState> extends StatelessWidget {
  const ItemListTemplateDynamic(this.widget, {Key? key}) : super(key: key);

  final T1 widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T2, T3>(
      buildWhen: (prev, current) => widget.buildWhen(prev, current),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.title(context, state),
              SingleChildScrollView(
                child: SizedBox(
                  height: widget.height(context),
                  child: InfiniteList(
                    itemCount: widget.itemCount(state),
                    onFetchData: () async {
                      widget.onFetchData(context, state);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return widget.itemBuilder(context, state, index);
                    },
                    emptyBuilder: (BuildContext context) {
                      return const Center(child: Text("검색 결과가 없습니다"));
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
