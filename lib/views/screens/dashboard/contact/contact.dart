import 'package:flutter/material.dart';

import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_fields.dart';

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
          'Contact US',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .345,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('We are available to support you all the way all the time.'),
                    SizedBox(height: 8,),
                    Text('Kindly reach out to us incase of any difficulty'),
                    SizedBox(height: 25,),
                    Text('Office', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    SizedBox(height: 25,),
                    Text('172, Aka Etinan Road'),
                    SizedBox(height: 8,),
                    Text('by Mbierebe Junction'),
                    SizedBox(height: 8,),
                    Text('Uyo, Nigeria'),
                    SizedBox(height: 25,),
                    Text('+234 (0) 803 929 5318', style: TextStyle(fontWeight: FontWeight.bold,color: Color(0XFF187226), fontSize: 16),),
                    SizedBox(height: 8,),
                    Text('support@esolink.com'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Connect with us on our social media handles', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 12,),
                   Row(
                     children: [
                       EsolinkIcons(
                         icons: "facebook",
                         size: 20,
                       ),
                       SizedBox(width: 20),
                       EsolinkIcons(
                         icons: "instagram",
                         size: 20,
                       ),
                       SizedBox(width: 20),
                       EsolinkIcons(
                         icons: "linkedin",
                         size: 20,
                       ),
                       SizedBox(width: 20),
                       EsolinkIcons(
                         icons: "twitter",
                         size: 20,
                       ),
                     ],
                   ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .55,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reach Out to Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(height: 15),
                    SizedBox(height: 8,),
                    PlainTextField(
                      label: "Email Address",
                      hint: "email@johndoe.com",
                    ),
                    PlainTextField(
                      label: "Subject",
                      hint: "email@johndoe.com",
                    ),
                    PlainTextField3(
                      label: "Product Description",
                      hint: "...",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                onTap: () {
                },
                text: "send",
              ),
            ),
            SizedBox(height: 85),
          ],
        ),
      ),
    );
  }
}
