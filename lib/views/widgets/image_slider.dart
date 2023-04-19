import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final String imageUrl;
  final int imageLength;
  const ImageSlider({Key? key, required this.imageUrl, required this.imageLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(imageLength, (index){
          return Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 100, width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Image.network(imageUrl, fit: BoxFit.cover, height: 100, width: 100),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
