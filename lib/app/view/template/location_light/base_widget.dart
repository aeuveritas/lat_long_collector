import 'package:flutter/material.dart';

import '../models/abstract_bloc_state.dart';

abstract class LocationLightBaseWidget {
  const LocationLightBaseWidget();

  Widget title(BuildContext context, AbstractFormzBlocState state);
  Widget map(BuildContext context, AbstractFormzBlocState state);
  bool buildWhen(AbstractFormzBlocState prev, AbstractFormzBlocState current);
}
