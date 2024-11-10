import 'dart:io';

enum PlatformType {
  ANDROID, IOS, WEB
}

class PlatformHelper {
  static const instance = PlatformHelper._();

  const PlatformHelper._();

  PlatformType get currentPlatform {
    if(Platform.isAndroid) {
      return PlatformType.ANDROID;
    } else if(Platform.isIOS) {
      return PlatformType.IOS;
    } else {
      return PlatformType.WEB;
    }
  }
}