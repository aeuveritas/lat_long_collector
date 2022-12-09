import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';

import 'app/app.dart';
import 'app/service/envs/env_mode_helper.dart';
import 'app/service/observers/bloc.dart';
import 'injections/kiwi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envModeHelper = EnvModeHelper();
  final kakaoAddressHandler = KakaoAddressHandler.create(envModeHelper.kakaoAPIKey, envModeHelper.blockIntervalSeconds);

  registerContainer(envModeHelper);

  Bloc.observer = BlocLifetimeObserver();

  runApp(App(
    kakaoAddressHandler: kakaoAddressHandler,
  ));
}
