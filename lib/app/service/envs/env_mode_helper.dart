import 'package:draccoon_logger/draccoon_logger.dart';

import 'env.dart';

enum EnvMode { dev, prod, unknown }

class EnvModeHelper with MixInLogger {
  EnvModeHelper() {
    const strMode = String.fromEnvironment('ENVIRONMENT');
    mode = strToEnvMode[strMode] ?? EnvMode.unknown;
  }

  final Map<String, EnvMode> strToEnvMode = {
    "DEV": EnvMode.dev,
    "PROD": EnvMode.prod,
  };

  late EnvMode mode;

  String get kakaoAPIKey {
    switch (mode) {
      case EnvMode.dev:
        return EnvDEV.kakaoAPIKey;
      case EnvMode.prod:
        return EnvPROD.kakaoAPIKey;
      case EnvMode.unknown:
        return EnvPROD.kakaoAPIKey;
    }
  }

  String get blockIntervalSeconds {
    switch (mode) {
      case EnvMode.dev:
        return EnvDEV.blockIntervalSeconds;
      case EnvMode.prod:
        return EnvPROD.blockIntervalSeconds;
      case EnvMode.unknown:
        return EnvPROD.blockIntervalSeconds;
    }
  }
}
