import 'package:flutter/material.dart';

import '../icons/esolink_icons.dart';

class accounts_Card extends StatelessWidget {
  const accounts_Card({Key? key, required this.iconText, required this.text, required this.onTap}) : super(key: key);

  final String iconText;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .07,
        child: Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:15.0),
                child: EsolinkIcons(
                  icons: "${this.iconText}",
                  size: 20,
                ),
              ),
              Text('${this.text}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),)
            ],
          ),
        ),
      ),
    );
  }
}
