import 'package:esolink/views/widgets/special_btn.dart';
import 'package:flutter/material.dart';

class requests_Card extends StatelessWidget {
  const requests_Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * .18,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .17,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/person.png'),
                  SizedBox(height: 10,),
                  Text('Completed', style: TextStyle(fontSize: 10, color: Color(0XFF187226)),)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Dunamis Photography', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              Icon(Icons.verified, color: Color(0XFF187226),size: 16,)
                            ],
                          ),
                          SizedBox(width: 50,),
                          Icon(Icons.delete, size: 30,color: Color(0XFF828282)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('⭐⭐⭐⭐⭐️'),
                          Text('(5 ratings)',style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 10,),
                          Text('*** **** 8721'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 10,),
                          Text('July 31, 2022',style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      special_Btn(text: 'Pay',color1: Color(0XFF187226),color2: Colors.white,),
                      SizedBox(width: 15,),
                      special_Btn(text: 'Rate',color1: Colors.white,color2: Color(0XFF187226)),
                      SizedBox(width: 15,),
                      special_Btn(text: 'Request again',color1: Colors.white,color2: Color(0XFF187226)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
