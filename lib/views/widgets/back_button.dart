import 'package:flutter/material.dart';

class EsolinkBackButton extends StatelessWidget {
  const EsolinkBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}
