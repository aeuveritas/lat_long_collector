import 'package:draccoon_logger/src/base_printer.dart';
import 'package:draccoon_logger/src/stack_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class DevLogger {
  final _logger = Logger(
    printer: BasePrinter(),
  );

  final _stackLogger = Logger(
    printer: StackPrinter(),
  );

  void info(msg) {
    _logger.i("DEVELOP $msg");
  }

  void debug(msg) {
    if (kDebugMode) {
      _logger.d("DEVELOP $msg");
    }
  }

  void stack(msg) {
    _stackLogger.d("DEVELOP $msg");
  }

  void errorException(Object e, String message) {
    final err = e as Error;
    _stackLogger.e("DEVELOP ${message}\n  ${err.toString()}\n  ${err.stackTrace}");
  }
}
