import 'package:flutter/material.dart';

class widthButton extends StatelessWidget {
  const widthButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0XFF187226),
          borderRadius: BorderRadius.circular(15.0)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .06,
      child: Center(child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white))),
    );
  }
}
