import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const OnboardingIndicator(
      {Key? key, required this.positionIndex, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionIndex == currentIndex ? 8 : 6,
      width: positionIndex == currentIndex ? 8 : 6,
      decoration: BoxDecoration(
        border: Border.all(
          color: positionIndex == currentIndex
              ? primaryColor
              : const Color(0xff828282),
        ),
        color: positionIndex == currentIndex
            ? primaryColor
            : const Color(0xff828282),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
