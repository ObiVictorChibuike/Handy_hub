import 'package:flutter/material.dart';

class faq_Card extends StatefulWidget {
  const faq_Card({Key? key, required this.title, required this.subTitle,}) : super(key: key);

  final String title;
  final String subTitle;

  @override
  State<faq_Card> createState() => _faq_CardState();
}

class _faq_CardState extends State<faq_Card> {

  bool show = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          show = !show;
        });
      },
      child: !show ? Container(
        height: MediaQuery.of(context).size.height * 0.077,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Text('${this.widget.title}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)),
                  Icon(Icons.navigate_next_rounded, color: Colors.black45, size: 20,),
                ],
              ),
            ],
          ),
        ),
      ) :
      Container(
        height: MediaQuery.of(context).size.height * 0.162,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * .8,
                  child: Text(widget.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)),
                  Icon(Icons.arrow_drop_down_rounded, color: Colors.black45, size: 20,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Text(widget.subTitle),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
