import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';

class special_Btn extends StatelessWidget {
  special_Btn({Key? key, required this.text, this.color1, this.color2, this.onTap}) : super(key: key);
  
  final String text;
  Color? color1;
  Color? color2;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(color: color1, borderRadius: BorderRadius.circular(5), border: Border.all(color: primaryColor)),
        child: Center(
          child: Text(text, style: TextStyle(color: color2, fontSize: 12),),
      )),
    );
  }
}
