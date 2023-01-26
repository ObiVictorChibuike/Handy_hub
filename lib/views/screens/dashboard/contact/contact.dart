import 'package:flutter/material.dart';

class contact_Page extends StatelessWidget {
  const contact_Page({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('We are available to support you all the way all the time.'),
                SizedBox(height: 8,),
                Text('Kindly reach out to us incase of any difficulty'),
                SizedBox(height: 25,),
                Text('Office'),
                SizedBox(height: 25,),
                Text('172, Aka Etinan Road'),
                SizedBox(height: 8,),
                Text('by Mbierebe Junction'),
                SizedBox(height: 8,),
                Text('Uyo, Nigeria'),
                SizedBox(height: 25,),
                Text('+234 (0) 803 929 5318'),
                SizedBox(height: 8,),
                Text('support@solink.com'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
