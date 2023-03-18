import 'package:flutter/material.dart';

class special_Btn extends StatelessWidget {
  special_Btn({Key? key, required this.text, this.color1, this.color2, this.onTap}) : super(key: key);
  
  final String text;
  Color? color1;
  Color? color2;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('${text}', style: TextStyle(color: color2, fontSize: 12),),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        backgroundColor: color1,
        side: BorderSide(
          color: Color(0XFF187226),
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      onPressed: onTap,
    );
  }
}
