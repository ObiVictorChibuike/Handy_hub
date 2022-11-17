import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.text, this.onTap, this.enabled = true})
      : super(key: key);

  final String? text;
  final VoidCallback? onTap;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ?? false ? onTap : () {},
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: (enabled ?? false ? primaryColor : primaryColor),
          border: Border.all(
              color: enabled ?? false
                  ? primaryColor
                  : primaryColor.withOpacity(.23)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "$text",
            style: subHeaderText.copyWith(fontSize: 13, color: white),
          ),
        ),
      ),
    );
  }
}

class GoHomeButtton extends StatelessWidget {
  const GoHomeButtton(
      {Key? key,
      this.widget,
      this.text,
      this.borderColor,
      this.cardColor,
      this.textColor})
      : super(key: key);
  final Widget? widget;
  final Color? borderColor, cardColor, textColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget != null
          ? () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => widget!));
            }
          : () {},
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: cardColor ?? white.withOpacity(.2),
          border: Border.all(color: borderColor ?? white),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            "$text".toUpperCase(),
            style:
                subHeaderText.copyWith(fontSize: 13, color: textColor ?? white),
          ),
        ),
      ),
    );
  }
}
