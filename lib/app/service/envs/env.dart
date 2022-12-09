import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class EnvDEV {
  @EnviedField(varName: 'KAKAO_API_KEY', obfuscate: true)
  static final kakaoAPIKey = _EnvDEV.kakaoAPIKey;
  @EnviedField(varName: 'BLOCK_INTERVAL_SECONDS', obfuscate: true)
  static final blockIntervalSeconds = _EnvDEV.blockIntervalSeconds;
}

@Envied(path: '.env.prod')
abstract class EnvPROD {
  @EnviedField(varName: 'KAKAO_API_KEY', obfuscate: true)
  static final kakaoAPIKey = _EnvPROD.kakaoAPIKey;
  @EnviedField(varName: 'BLOCK_INTERVAL_SECONDS', obfuscate: true)
  static final blockIntervalSeconds = _EnvPROD.blockIntervalSeconds;
}
