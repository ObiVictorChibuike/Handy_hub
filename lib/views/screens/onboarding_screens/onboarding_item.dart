import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String? image;
  final String? title, description;
  const OnboardingItem({
    Key? key,
    this.image,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Header",
                  style: headerStyle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                    description ??
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
                    style: subHeaderText.copyWith(
                        color: const Color(0xff4F4F4F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
