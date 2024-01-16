import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double dynamicHeight(double multiplier) {
    return mediaQuery.orientation == Orientation.landscape ? height * (multiplier / 450) : height * (multiplier / 812);
  }

  double dynamicSquareContainerHeight(double multiplier) {
    return mediaQuery.orientation == Orientation.landscape ? height * (multiplier / 375) : height * (multiplier / 812);
  }

  double dynamicSquareContainerWidth(double multiplier) {
    return mediaQuery.orientation == Orientation.landscape ? width * (multiplier / 812) : width * (multiplier / 375);
  }

  double dynamicWidth(double multiplier) {
    return mediaQuery.orientation == Orientation.landscape ? width * (multiplier / 974.4) : width * (multiplier / 375);
  }
}

extension ColorExtension on BuildContext {
  Color get mainAppColor => Colors.deepPurple;
  Color get appBlack => Colors.black;
  Color get appWhite => Colors.white;
  Color get appColor => Colors.deepPurple;
}

extension TextStyleExtansion on BuildContext {
  TextStyle get normalTextStyle => const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  TextStyle get bigTextStyle => const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}

extension AppPaddings on BuildContext {
  EdgeInsets get appPadding => const EdgeInsets.all(16);
}
