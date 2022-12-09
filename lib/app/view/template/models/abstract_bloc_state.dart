import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

abstract class AbstractBlocState extends Equatable {
  const AbstractBlocState();

  bool get isSavable;
}

abstract class AbstractFormzBlocState extends Equatable {
  const AbstractFormzBlocState(this.status);

  final FormzStatus status;

  FormzInput getCube();
  bool get isSavable;

  dynamic get output;
}
