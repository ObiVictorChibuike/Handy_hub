import 'package:flutter/material.dart';

class faq_Card extends StatelessWidget {
  const faq_Card({Key? key, required this.title, required this.onTap }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${this.title}', style: TextStyle(fontSize: 15),),
              Icon(Icons.navigate_next_rounded, color: Colors.black45, size: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
