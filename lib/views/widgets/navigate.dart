import 'package:flutter/material.dart';

VoidCallback navigate(BuildContext? context, Widget? widget) {
  return () {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => widget!));
  };
}
