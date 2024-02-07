class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    return _instance ??= ImageConstants._init();
  }

  ImageConstants._init();
  String get googleLogo => toPng('logo/google-logo');
  String get appLogo => toPng('logo/app_logo');

  String toPng(String name) => 'assets/images/$name.png';
}

/* /Users/mac/Desktop/software development/flutter/chat_app/assets/images/logo/google-logo.png */