import 'package:flutter/material.dart';

import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';
import 'ordersList.dart';

class orders_Page extends StatelessWidget {
  const orders_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: Column(
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
                          return orders_List();
                        }));
                  },
                  text: "Place an Order",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
