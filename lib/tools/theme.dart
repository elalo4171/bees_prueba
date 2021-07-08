import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColorDark: const Color(0xFF1B191F),
  primaryColorLight: const Color(0xFFEDF0F2),
  primaryColor: const Color(0xFF33048A),
  accentColor: const Color(0xFFFB8326),
  scaffoldBackgroundColor: Colors.white,
  buttonColor: const Color(0xFF007AFF),
  shadowColor: const Color(0xFFF2F2F2),
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Colors.white;
      },
    ),
    trackColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Colors.transparent;
      },
    ),
  ),
  textTheme: TextTheme(
    headline3: TextStyle(
      color: const Color(0xFF4D4D4D),
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    caption: TextStyle(color: const Color(0xFF007AFF), fontSize: 18),
  ),
);

extension BookTheme on ThemeData {
  Color get redAccentColor => const Color(0xffEB7C78);
  Color get test => const Color(0xFFF9B44D);
}
