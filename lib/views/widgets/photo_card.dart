import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key, this.imageUrl}) : super(key: key);

  final String? imageUrl;
  @override
  Widget build(BuildContext context) { 
    return Container(
      height: 76,
      width: 76,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageUrl == "file:///null"
                  ? "https://res.cloudinary.com/esolink/image/upload/v1644743449/engomb1fiyuul51ubmxq.jpg"
                  : imageUrl!)),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
