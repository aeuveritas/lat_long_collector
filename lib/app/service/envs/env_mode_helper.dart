import 'env.dart';

class EnvModeHelper {
  const EnvModeHelper();

  String get kakaoAPIKey {
    return Env.kakaoAPIKey;
  }

  String get blockIntervalSeconds {
    return Env.blockIntervalSeconds;
  }
}
