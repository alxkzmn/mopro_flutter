
import 'mopro_flutter_platform_interface.dart';

class MoproFlutter {
  Future<String?> getPlatformVersion() {
    return MoproFlutterPlatform.instance.getPlatformVersion();
  }
}
