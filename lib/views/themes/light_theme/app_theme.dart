import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_bar_theme.dart';
import 'app_input_theme.dart';

ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.montserratTextTheme(
    
  ),
    colorScheme: ThemeData.light()
        .colorScheme
        .copyWith(primary: primaryColor, secondary: primaryColor),
    backgroundColor: Colors.white,
    appBarTheme: lightAppBarTheme,
    inputDecorationTheme: lightInputDecorationTheme);
