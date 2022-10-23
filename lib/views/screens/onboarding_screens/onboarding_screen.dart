import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/screens/sign_up/sign_up_selections.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'onboarding_indicator.dart';
import 'onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(
              flex: 4,
              child: PageView(
                controller: _pageController,
                onPageChanged: onChangedFunction,
                children: const [
                  OnboardingItem(
                    image: 'assets/images/onboarding_1.gif',
                  ),
                  OnboardingItem(
                    image: 'assets/images/onboarding_1.gif',
                  ),
                  OnboardingItem(
                    image: 'assets/images/onboarding_1.gif',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: CustomButton(
                enabled: true,
                onTap: () {
                  currentIndex < 2
                      ? _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut)
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpSelection()));
                },
                text: "Get Started",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OnboardingIndicator(
                    positionIndex: 0, currentIndex: currentIndex),
                const SizedBox(
                  width: 5,
                ),
                OnboardingIndicator(
                    positionIndex: 1, currentIndex: currentIndex),
                const SizedBox(
                  width: 5,
                ),
                OnboardingIndicator(
                    positionIndex: 2, currentIndex: currentIndex),
                const SizedBox(
                  width: 5,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
            const SizedBox(height: 71),
          ],
        ));
  }
}
