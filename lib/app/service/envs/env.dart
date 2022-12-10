import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KAKAO_API_KEY', obfuscate: true)
  static final kakaoAPIKey = _Env.kakaoAPIKey;
  @EnviedField(varName: 'BLOCK_INTERVAL_SECONDS', obfuscate: true)
  static final blockIntervalSeconds = _Env.blockIntervalSeconds;
}
