import 'package:flutter/material.dart';

// import '../constant/font_constant.dart';
import '../constant/color_constant.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeData? _selectedTheme;
  // static const fontFamilyNormal = kFuturaPTBook;
  // static const fontFamilyMedium = kFuturaPTMedium;

  static BoxDecoration scaffoldDecoration =
      BoxDecoration(color: Color.fromARGB(255, 255, 200, 0));

  static ThemeData primary = ThemeData(
    // fontFamily: fontFamilyNormal,
    splashColor: const Color(0x7E112E78),
    disabledColor: const Color(0xFF003399),
    scaffoldBackgroundColor: kBackGroundColor,
    hintColor: Colors.black54,
    highlightColor: Colors.transparent,
    // textTheme: const TextTheme(
    //   bodyMedium: TextStyle(fontFamily: fontFamilyMedium),
    // ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      titleTextStyle: TextStyle(fontSize: 22, color: kBlackColor),
    ),
    listTileTheme: const ListTileThemeData(textColor: kPrimaryColor),
    primaryColor: Colors.red,
    primaryColorDark: Colors.red,
    sliderTheme: const SliderThemeData(
      activeTickMarkColor: Colors.black54,
      activeTrackColor: Colors.black54,
      overlayColor: Colors.black54,
      inactiveTickMarkColor: Colors.black45,
      inactiveTrackColor: Colors.black45,
      thumbColor: Colors.black54,
    ),
    iconTheme: const IconThemeData(
      color: kBlack54Color,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
        backgroundColor: MaterialStateProperty.all(kButtonColor),
      ),
    ),
  );

  ThemeProvider(isDarkTheme) {
    scaffoldDecoration = BoxDecoration(color: Color.fromARGB(255, 255, 200, 0));
    _selectedTheme = primary;
  }

  ThemeData? getTheme() => _selectedTheme;
}
