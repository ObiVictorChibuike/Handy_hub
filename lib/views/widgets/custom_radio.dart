import 'dart:developer';
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool? value;
  const CustomRadio({Key? key, this.onChanged, this.value = false}) : super(key: key);

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        setState(() {
          widget.onChanged != null? widget.onChanged!(!widget.value!) : null;
          log(widget.value.toString());
        });
      },
      child: Container(
          height: 20, width: 20,
          decoration: BoxDecoration(border: Border.all(color: widget.value == true ? primaryColor : Colors.grey, width: 2), shape: BoxShape.circle),
          child: widget.value == true ? Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 17, width: 17,
              decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor,),
            ),
          ) : Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 17, width: 17,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey,),
            ),
          )
      ),
    );
  }
}
