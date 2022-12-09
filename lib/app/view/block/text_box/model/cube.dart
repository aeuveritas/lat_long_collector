import 'package:formz/formz.dart';

import '../../../../consts/app_texts.dart';
import '../../../../consts/static.dart';

enum TextBoxCubeValidationError { empty, minViolation, maxViolation }

class TextBoxCube extends FormzInput<String, TextBoxCubeValidationError> {
  const TextBoxCube.pure([this.minLength = MIN_TEXT_LENGTH, this.maxLength = MAX_TEXT_LENGTH]) : super.pure('');
  const TextBoxCube.dirty([String value = '', this.minLength = MIN_TEXT_LENGTH, this.maxLength = MAX_TEXT_LENGTH])
      : super.dirty(value);

  final int maxLength;
  final int minLength;

  @override
  TextBoxCubeValidationError? validator(String value) {
    if (minLength != 0 && value.isEmpty) {
      return TextBoxCubeValidationError.empty;
    }
    if (minLength != 0 && value.length < minLength) {
      return TextBoxCubeValidationError.minViolation;
    }
    if (maxLength != 0 && value.length > maxLength) {
      return TextBoxCubeValidationError.maxViolation;
    }
    return null;
  }

  String? errorMessage() {
    if (!invalid) {
      return null;
    }
    switch (error) {
      case TextBoxCubeValidationError.empty:
        return ERROR_EMPTY_STRING_INPUT;
      case TextBoxCubeValidationError.minViolation:
        return "최소 $minLength자 이상 입력해 주세요";
      case TextBoxCubeValidationError.maxViolation:
        return "최대 $maxLength자 까지만 가능합니다";
      default:
        return null;
    }
  }
}
