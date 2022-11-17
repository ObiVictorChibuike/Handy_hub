import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class OnboardingTitleCard extends StatelessWidget {
  const OnboardingTitleCard({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      height: 40,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Center(
        child: Text(
          "$title",
          textAlign: TextAlign.center,
          style: subHeaderText.copyWith(
              fontSize: 24, fontWeight: FontWeight.w500, color: primaryColor),
        ),
      ),
    );
  }
}

class OnboardingDetailsCard extends StatelessWidget {
  const OnboardingDetailsCard({Key? key, this.descriptions}) : super(key: key);
  final String? descriptions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff187226).withOpacity(.8)),
        child: Text(
          "$descriptions",
          style: subHeaderText.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500, color: white),
        ),
      ),
    );
  }
}
