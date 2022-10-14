import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EsolinkIcons extends StatelessWidget {
  const EsolinkIcons({Key? key, this.icons, this.image, this.color, this.size})
      : super(key: key);

  final String? icons, image;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return icons == null
        ? Image.asset(
            "assets/images/$image.png",
            color: color,
            height: size,
            width: size,
            fit: BoxFit.contain,
          )
        : SvgPicture.asset(
            "assets/images/$icons.svg",
            color: color,
            height: size,
            width: size,
            fit: BoxFit.fitHeight,
          );
  }
}
