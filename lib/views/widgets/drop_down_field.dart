import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropDownTextField extends StatefulWidget {
  final List<DropdownMenuItem<Object>>? items;
  final String? title;
  final void Function(Object?)? onChanged;
  const DropDownTextField({Key? key, this.items, this.title, this.onChanged}) : super(key: key);

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor, width: 0.7)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor, width: 0.7)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor, width: 0.7)),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor, width: 0.7)),
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor, width: 0.7)),
      ),
      isExpanded: true,
      hint: Text(widget.title ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xff868484), fontSize: 15)),
      items: widget.items,
      onChanged: widget.onChanged,
      buttonStyleData: ButtonStyleData(height: 48, padding: const EdgeInsets.only(left: 0, right: 10),
          decoration: BoxDecoration(color: const Color(0xffEFEFF0), borderRadius: BorderRadius.circular(10), border: Border.all(color: primaryColor, width: 0.7))),
      iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 18,), iconSize: 30,),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: primaryColor)
        ),
      ),
    );
  }
}
