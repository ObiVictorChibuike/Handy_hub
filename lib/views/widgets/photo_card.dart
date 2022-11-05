import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: 344,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/photo_model.png")),
                      ),
                    ),
                  ));
        },
        child: Container(
          height: 76,
          width: 76,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/photo_model.png")),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
