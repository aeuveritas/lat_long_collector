import 'package:draccoon_logger/src/base_printer.dart';
import 'package:draccoon_logger/src/stack_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

mixin MixInLogger {
  final _logger = Logger(
    printer: BasePrinter(),
  );

  final _stackLogger = Logger(
    printer: StackPrinter(),
  );

  void info(String msg) {
    _logger.i("$runtimeType $msg");
  }

  void debug(String Function() callback) {
    if (kDebugMode) {
      _logger.d("$runtimeType ${callback()}");
    }
  }

  void exceptionHandle(Exception e, String message) {
    _stackLogger.e("$runtimeType ${message}\n  ${e.toString()}\n");
  }

  void errorHandle(Error e, String message) {
    _stackLogger.e("$runtimeType ${message}\n  ${e.toString()}\n  ${e.stackTrace}");
  }

  void warn(dynamic err) {
    _logger.w("$runtimeType $err");
  }
}
