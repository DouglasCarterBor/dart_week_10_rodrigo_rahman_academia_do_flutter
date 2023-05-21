
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class ThemeConfig {
  
  ThemeConfig._();

  static final _defaultImputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.grey[400]!),
  );

  static final theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.instance.primaryColor,
        primary: ColorsApp.instance.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.instance.prymaryButton,
      ),
    inputDecorationTheme: InputDecorationTheme(
     fillColor: Colors.white,
     filled: true,
     isDense: true,
     contentPadding: const EdgeInsets.all(15),
     border: _defaultImputBorder,
     enabledBorder: _defaultImputBorder,
     focusedBorder: _defaultImputBorder,
     labelStyle: TextStyles.instance.textRegular.copyWith(color: Colors.black),
     errorStyle: TextStyles.instance.textRegular.copyWith(color: Colors.redAccent),
    ),
  );
}