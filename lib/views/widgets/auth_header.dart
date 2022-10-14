import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key, this.subTitle, this.title}) : super(key: key);

  final String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: headerStyle,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          "$subTitle",
          style: subHeaderText,
        )
      ],
    );
  }
}
