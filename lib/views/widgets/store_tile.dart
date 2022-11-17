import 'package:flutter/material.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(bottom: 10, left: 8, child: Text("$title")),
      Container(
        height: 113,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/staggered.png"))),
      ),
    ]);
  }
}
