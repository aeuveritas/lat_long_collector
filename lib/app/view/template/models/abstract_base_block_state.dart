import 'package:formz/formz.dart';

import 'abstract_bloc_state.dart';

abstract class MandatoryBlockState extends AbstractFormzBlocState {
  const MandatoryBlockState(FormzStatus status) : super(status);

  @override
  bool get isSavable => status.isValidated;
}

abstract class OptionalBlockState extends AbstractFormzBlocState {
  const OptionalBlockState(FormzStatus status) : super(status);

  @override
  bool get isSavable => status.isValidated || status.isPure;
}

abstract class CustomBlockState extends AbstractFormzBlocState {
  const CustomBlockState(FormzStatus status) : super(status);
}
