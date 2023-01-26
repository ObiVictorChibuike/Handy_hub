import 'package:flutter/material.dart';

import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';
import 'inventoryList.dart';

class inventory_Page extends StatelessWidget {
  const inventory_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Inventory',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: Column(
            children: [
              const EsolinkIcons(
                icons: "inventory",
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
                          return inventory_List();
                        }));
                  },
                  text: "Add Inventory",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
