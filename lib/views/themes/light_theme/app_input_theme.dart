import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    gapPadding: 15,
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Color(0xffBDBDBD)));

OutlineInputBorder focusedInputBorder = OutlineInputBorder(
    gapPadding: 15,
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(width: 1, color: primaryColor));

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    focusedBorder: focusedInputBorder,
    errorBorder: outlineInputBorder,
    filled: true,
    enabledBorder: outlineInputBorder,
    contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    fillColor: const Color(0xffF2F2F2),
    hintStyle: GoogleFonts.montserrat(
        color: const Color(0xff828282),
        fontWeight: FontWeight.w300,
        fontSize: 14));
