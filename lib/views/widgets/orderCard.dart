import 'package:flutter/material.dart';

class order_Card extends StatelessWidget {
  const order_Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .17,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/testImage.png'),
                    Text('Completed', style: TextStyle(color: Color(0XFF219653)),),
                    Text('10/10/21')
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('15 Hand Cream with SPF For Summers'),
                    Text('Variation: 150ml'),
                    Text('Order No: 125252525252'),
                    Text('QTY: 1'),
                    Text('#7,500', style: TextStyle(color: Color(0XFF219653), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
