import 'package:kiwi/kiwi.dart';

import '../app/service/envs/env_mode_helper.dart';

void registerContainer(EnvModeHelper envModeHelper) {
  KiwiContainer container = KiwiContainer();
  container.registerInstance<EnvModeHelper>(envModeHelper);
}

void unregisterContainer() {
  KiwiContainer().unregister<EnvModeHelper>();
}
