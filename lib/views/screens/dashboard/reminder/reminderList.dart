import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/inventoryCard.dart';
import '../../../widgets/reminderCard.dart';

class reminder_List extends StatelessWidget {
  const reminder_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF2F2F2),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            reminder_Card(color: Color(0XFFADFFBA),),
            reminder_Card(color: Color(0XFFFFDFB5),),
            reminder_Card(color: Color(0XFFADFFBA),),
            reminder_Card(color: Color(0XFFFFDFB5),),
            reminder_Card(color: Color(0XFFADFFBA),),
            reminder_Card(color: Color(0XFFFFDFB5),),
            reminder_Card(color: Color(0XFFADFFBA),),
            reminder_Card(color: Color(0XFFFFDFB5),),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          onTap: () {
          },
          text: "Add Inventory",
        ),
      ),
    );
  }
}
