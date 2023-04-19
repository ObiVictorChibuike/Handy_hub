import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  const IconBox({Key? key, this.image, this.color, this.height, this.width}) : super(key: key);

  final String? image;
  final Color? color;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xff284065).withOpacity(.1)),
      child: Image.asset(
        "assets/images/$image.png",
        color: color,
        height: height,
        width: width,
        fit: BoxFit.contain,
      )
    );
  }
}
