import 'package:flutter/material.dart';
import 'package:get/get.dart';

const title = 'WithU';
const duration = Duration(milliseconds: 200);
const double padding = 16;

var appTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.pink,
    checkboxTheme: CheckboxThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black38));

String? validateField(String fieldName, String value) {
  if (value.isEmpty) return '$fieldName is required.';
  if (value.length < 3)
    return '$fieldName should be atleast 3 characters long.';
  return null;
}

showToast(String message,
        {String title = "Alert",
        bool instantInit = true,
        Color backgroundColor = Colors.black,
        Color textColor = Colors.white,
        Widget icon = const Icon(Icons.info, color: Colors.white),
        bool shouldIconPulse = false,
        Duration? duration,
        Duration? animationDuration,
        SnackPosition position = SnackPosition.BOTTOM}) =>
    Get.snackbar(title, message,
        backgroundColor: backgroundColor,
        snackPosition: position,
        duration: duration,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        icon: Padding(padding: EdgeInsets.only(left: 10), child: icon),
        shouldIconPulse: shouldIconPulse,
        instantInit: instantInit,
        animationDuration: animationDuration,
        colorText: textColor);
