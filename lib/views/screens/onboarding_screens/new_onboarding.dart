import 'package:esolink/views/widgets/onboarding_title_card.dart';
import 'package:flutter/material.dart';

class NewOnboardingScreen extends StatelessWidget {
  const NewOnboardingScreen(
      {Key? key, this.description, this.image, this.title})
      : super(key: key);

  final String? image, title, description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          Center(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/$image.png")))
                ),
          ),
          Container( 
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ])),
          ),
          Positioned(
            top: 60,
            child: OnboardingTitleCard(
              title: "$title",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 88),
            child: Align( 
              alignment: Alignment.bottomCenter,
              child: OnboardingDetailsCard(
                descriptions: description ??
                    "Speak directly with professionals, negotiate price and pay securely though esolink app.Esolink will monitor to ensure your job is completed to your satisfaction.",
              ),
            ),
          )
        ]),
      ),
    );
  }
}
