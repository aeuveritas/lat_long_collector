import 'dart:async';

import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../models/form_component.dart';
import '../../template/models/abstract_bloc_state.dart';

class SubBlocManager with MixInLogger {
  SubBlocManager({
    required StreamController<FormComponent> updateStreamController,
    required this.blocs,
  });

  final Map<String, Bloc> blocs;

  void close() {
    for (var element in blocs.values) {
      element.close();
    }
  }

  @override
  String toString() {
    return "status: { blocs: $blocs }";
  }

  List<FormzInput> get cubes {
    return blocs.entries.map((entry) {
      final state = entry.value.state as AbstractFormzBlocState;
      return state.getCube();
    }).toList();
  }

  bool get isSavable {
    return blocs.values.every((bloc) {
      final state = bloc.state as AbstractFormzBlocState;
      final isSavable = state.isSavable;
      if (!isSavable) {
        debug(() => "[isSavable] ${bloc.runtimeType} is not savable in ${runtimeType}");
      }
      return isSavable;
    });
  }

  dynamic pullData(String key) {
    return blocs[key]!.state.output;
  }

  Bloc pullBloc(String key) {
    return blocs[key]!;
  }
}
