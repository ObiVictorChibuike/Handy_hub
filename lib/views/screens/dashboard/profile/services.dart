import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';

class services_Page extends StatelessWidget {
  const services_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .78,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/cake.png'),
                        SizedBox(height: 5,),
                        Text('Wedding Shoot'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/wedding.png'),
                        SizedBox(height: 5,),
                        Text('Wedding Shoot'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/family.png'),
                        SizedBox(height: 5,),
                        Text('Wedding Shoot'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/woman.png'),
                        SizedBox(height: 5,),
                        Text('Wedding Shoot'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/add.png'),
                        SizedBox(height: 5,),
                        Text('Wedding Shoot'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
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
    );
  }
}
