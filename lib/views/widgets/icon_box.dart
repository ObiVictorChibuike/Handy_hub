import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  const IconBox({Key? key, this.icon}) : super(key: key);

  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xff284065).withOpacity(.1)),
      child: const Icon(
        Icons.person,
        size: 12,
      ),
    );
  }
}
