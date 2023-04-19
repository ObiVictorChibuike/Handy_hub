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
      appBar: AppBar(
        title: Text("Delivery"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:90.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const EsolinkIcons(
                  icons: "delivery_1",
                  size: 380,
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const AllDeliveryScreen();
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
