import 'package:esolink/views/widgets/special_btn.dart';
import 'package:flutter/material.dart';

class reminder_Card extends StatelessWidget {
  const reminder_Card({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .21,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(17), topLeft: Radius.circular(17)),
                color: this.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right:15,top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1234568291', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Text('Tissue Paper', style: TextStyle(fontSize: 10),),
                      ],
                    ),
                    Icon(Icons.save,color: Color(0XFF187226),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80, top:10, bottom: 10.0),
              child: Row(
                children: [
                  Text('Service Category:', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Photography', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80, top:10, bottom: 10.0),
              child: Row(
                children: [
                  Text('Service Provider:', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Dunamis Photography', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                special_Btn(text: 'Postpone',color1: Color(0XFF187226),color2: Colors.white,),
                special_Btn(text: 'Request',color1: Color(0XFF187226),color2: Colors.white,),
                special_Btn(text: 'Dismiss',color1: Color(0XFF187226),color2: Colors.white,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
