
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/onboarding_screens/new_onboarding.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboarding_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  final _dbController = Get.put(DashboardController());

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

  Future<void> hasOnBoarded() async {
    if(mounted){
      Get.put<LocalCachedData>(await LocalCachedData.create());
      LocalCachedData.instance.cacheHasOnBoardedStatus(hasOnBoarded: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Container(
          height: double.infinity, width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: onChangedFunction,
                  children: const [
                    NewOnboardingScreen(
                      title: "Easy Access",
                      description:
                          "Handyhub will connect you to the best rated service provider, store vendor or Dispatch rider within few minutes of your location.",
                      image: 'onboarding_1',
                    ),
                    NewOnboardingScreen(
                      title: "Service delivery",
                      description:
                          "Speak directly with customers, negotiate price, and pay directly THROUGH HANDYHUB App. Handyhub will monitor to ensure your job is completed to your satisfaction.",
                      image: 'onboarding_2',
                    ),
                    NewOnboardingScreen(
                      title: "Nearby Shopping",
                      description:
                          "Select the location you wish to shop from and get access to store vendors in that location only. Instant refund policy if what you paid for is not what is brought to you.",
                      image: 'onboarding_3',
                    ),
                    NewOnboardingScreen(
                      title: "Service Reminder",
                      description:
                          "Set REMINDER notification for when next you need any service on Handyhub app and get reminded on that date.",
                      image: 'onboarding_4',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 51,
              ),
              Visibility(
                visible: currentIndex < 3,
                replacement: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: CustomButton(
                    enabled: true,
                    onTap: () async {
                     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpSelection()));
                      hasOnBoarded();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {return const Dashboard();}));
                    },
                    text: "Get Started",
                  ),
                ),
                child: Row(
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
                    OnboardingIndicator(
                        positionIndex: 3, currentIndex: currentIndex),
                  ],
                ),
              ),
              // // Visibility(
              //   visible: currentIndex == 3,
              //   // replacement:
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 22),
              //   child: CustomButton(
              //     enabled: true,
              //     onTap: () {
                      // currentIndex < 2
                      //     ? _pageController.nextPage(
                      //         duration: const Duration(milliseconds: 300),
                      //         curve: Curves.easeInOut)
                      //     : Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => SignUpSelection()));
              //     },
              //     text: "Get Started",
              //   ),
              // ),
              // ),
              const SizedBox(
                height: 24,
              ),
              // const SizedBox(height: 71),
            ],
          ),
        ));
  }
}
