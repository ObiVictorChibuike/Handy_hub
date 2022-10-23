 
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart'; 

progressIndicator(BuildContext? context) {
  showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) => Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 1),
          child: LinearProgressIndicator(
            color: primaryColor.withOpacity(.23),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          )));
 
}
