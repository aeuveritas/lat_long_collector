import 'package:flutter/material.dart';

import '../models/abstract_bloc_state.dart';

abstract class ItemListTemplateBaseWidget {
  const ItemListTemplateBaseWidget();

  Widget title(BuildContext context, AbstractFormzBlocState state);
  bool buildWhen(AbstractFormzBlocState prev, AbstractFormzBlocState current);
  void onFetchData(BuildContext context, AbstractFormzBlocState state);
  Widget itemBuilder(BuildContext context, AbstractFormzBlocState state, int index);
  int itemCount(AbstractFormzBlocState state);
  double height(BuildContext context);
}
