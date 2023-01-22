import 'package:esolink/views/widgets/photo_card.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_decoration.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: white,
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Service",
                style: subHeaderText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const [
                  PhotoCard(),
                  PhotoCard(),
                  PhotoCard(),
                  PhotoCard(),
                  PhotoCard(),
                ]),
              ),
             
            ],
          ),
        ));
  }
}
