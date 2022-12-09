part of 'bloc.dart';

class TextBoxBlockState extends CustomBlockState with MixInLogger {
  TextBoxBlockState({
    FormzStatus status = FormzStatus.pure,
    this.cube = const TextBoxCube.pure(),
    this.pureAllowed = false,
    this.textEditingControllerUpdateRequired = false,
  }) : super(status);

  final TextBoxCube cube;

  final bool pureAllowed;

  // if true, change UI text as state text
  final bool textEditingControllerUpdateRequired;

  @override
  String toString() {
    return "{ status: $status, cubeValue: ${cube.value}, pureAllowed: $pureAllowed,"
        " textEditingControllerUpdateRequired: $textEditingControllerUpdateRequired }";
  }

  TextBoxBlockState copyWith({
    FormzStatus? status,
    TextBoxCube? cube,
    bool? textEditingControllerUpdateRequired,
  }) {
    return TextBoxBlockState(
      status: status ?? this.status,
      cube: cube ?? this.cube,
      textEditingControllerUpdateRequired:
          textEditingControllerUpdateRequired ?? this.textEditingControllerUpdateRequired,
      pureAllowed: pureAllowed,
    );
  }

  @override
  List<Object> get props => [
        status,
        cube,
        pureAllowed,
        textEditingControllerUpdateRequired,
      ];

  @override
  FormzInput getCube() {
    // TODO: implement getCube
    throw UnimplementedError();
  }

  @override
  // TODO: implement isSavable
  bool get isSavable => throw UnimplementedError();

  @override
  // TODO: implement output
  get output => cube.value;
}
