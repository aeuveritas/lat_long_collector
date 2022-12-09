part of 'bloc.dart';

abstract class TextBoxBlockEvent extends Equatable {
  const TextBoxBlockEvent();

  @override
  List<Object?> get props => [];
}

class TextBoxBlockChanged extends TextBoxBlockEvent {
  final String text;
  final bool textEditingControllerUpdateRequired;

  const TextBoxBlockChanged(this.text, this.textEditingControllerUpdateRequired);

  @override
  List<Object> get props => [text, textEditingControllerUpdateRequired];
}

class TextBoxBlockTextEditingControllerUpdated extends TextBoxBlockEvent {
  const TextBoxBlockTextEditingControllerUpdated();
}
