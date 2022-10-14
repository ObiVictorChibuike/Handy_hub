import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';

import 'app_bar_theme.dart';
import 'app_input_theme.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "Lexend",
    colorScheme: ThemeData.light()
        .colorScheme
        .copyWith(primary: primaryColor, secondary: primaryColor),
    backgroundColor: Colors.white,
    appBarTheme: lightAppBarTheme,
    inputDecorationTheme: lightInputDecorationTheme);
