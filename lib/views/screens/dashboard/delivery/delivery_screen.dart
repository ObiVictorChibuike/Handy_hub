import 'package:flutter/material.dart';

import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/page_with_back_button.dart';
import 'allDelivery_screen.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        title: "Delivery",
        automaticallyImplyLeading: false,
        body: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const EsolinkIcons(
                icons: "delivery_1",
                size: 380,
              ),
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return allDeliveryScreen();
                              }));
                        },
                        text: "Make a request",
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
