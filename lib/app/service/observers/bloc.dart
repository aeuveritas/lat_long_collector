import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLifetimeObserver extends BlocObserver with MixInLogger {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debug(() => "[${bloc.runtimeType}] created");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debug(() => "[${bloc.runtimeType}] closed");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debug(() => "[${bloc.runtimeType}] error: $error\n$stackTrace");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debug(() => '[${bloc.runtimeType}] Change from: ${change.currentState}');
    debug(() => '[${bloc.runtimeType}] Change  to : ${change.nextState}');
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   debug('[${bloc.runtimeType}] transition: $transition');
  // }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debug(() => '[${bloc.runtimeType}] event: $event');
  }
}
