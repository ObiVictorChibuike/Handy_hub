import 'package:esolink/views/screens/dashboard/reminder/reminderList.dart';
import 'package:flutter/material.dart';

import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';

class reminder_Page extends StatelessWidget {
  const reminder_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Reminder',
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
                icons: "reminderImg",
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
                          return reminder_List();
                        }));
                  },
                  text: "Add Reminder",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
