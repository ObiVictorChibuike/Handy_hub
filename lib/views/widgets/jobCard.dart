import 'package:flutter/material.dart';

class jobs_Card extends StatelessWidget {
  const jobs_Card({Key? key}) : super(key: key);

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
                    Image.asset('assets/images/testImage2.png'),
                    Text('Completed', style: TextStyle(color: Color(0XFF219653)),)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sleek fabrics plus'),
                    Text('Ememokpokam@gmail.com'),
                    Row(
                      children: [
                        Icon(Icons.edit_calendar, size: 18,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('July 31, 2020'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Color(0XFF219653),size: 18,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('08099765432'),
                      ],
                    ),
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
