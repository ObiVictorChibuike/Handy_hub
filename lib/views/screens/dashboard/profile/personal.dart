import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';

class personal_Page extends StatelessWidget {
  const personal_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/personal_img.png'),
                      SizedBox(height: 10,),
                      Text('Tap to change picture')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .63,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10) ,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .21,
                        decoration: BoxDecoration(
                          color: Color(0XFFE5E5E5),
                          border: Border.all(
                            color: Colors.black45
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              SizedBox(height: 10,),
                              Text('But I must explain to you how all this mistaken idea of reprobating pleasure and extolling pain arose. \n To do so, I will give you a complete account of the system, and expound the actual teachings of the \n great explorer of the truth, the master-builder of human happiness.')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 85)
                    ),
                  ), onPressed: (){}, child: Text('http://esolink.com/invite')),
                  ElevatedButton(style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 120)
                    ),
                  ),onPressed: (){}, child: Text('Refer a friend')),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Business Name:'),
                            SizedBox(height: 10,),
                            Text('Type of Service:'),
                            SizedBox(height: 10,),
                            Text('Physical Address:'),
                            SizedBox(height: 10,),
                            Text('Phone Number:'),
                            SizedBox(height: 10,),
                            Text('Address:'),
                            SizedBox(height: 10,),
                            Text('Referral Code:'),
                          ],
                        ),
                        SizedBox(width: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dunamis Photography'),
                            SizedBox(height: 10,),
                            Text('Photography'),
                            SizedBox(height: 10,),
                            Text('Block C Ozumba Complex'),
                            SizedBox(height: 10,),
                            Text('0809 888 9833'),
                            SizedBox(height: 10,),
                            Text('Ozumba mbadu way'),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('EVTGH657JP'),
                                Icon(Icons.copy,color: Colors.black,)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                onTap: () {

                },
                text: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
