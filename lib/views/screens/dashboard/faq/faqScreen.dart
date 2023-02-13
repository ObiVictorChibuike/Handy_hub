import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/views/widgets/faqCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/faq_model.dart';

class faq_Page extends StatefulWidget {
  const faq_Page({Key? key}) : super(key: key);

  @override
  State<faq_Page> createState() => _faq_PageState();
}

  

class _faq_PageState extends State<faq_Page> {

  final List<Faq> _faqs = <Faq>[];
  
  @override
  void initState() {
    // TODO: implement initState
    ApiServices().getFaqs().then((value) => setState((){
      _faqs.addAll(value);
    }));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text('FAQ'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
         children: [
           SizedBox(height: 20,),
           StreamBuilder<List<Faq>>(
              stream: ApiServices().getFaqs().asStream(),
               builder:(context, snapshot){
                 while (!snapshot.hasData) {
                   return const Center(
                       child: CupertinoActivityIndicator());
                 }
                 return Container(
                   height: MediaQuery.of(context).size.height,
                   child: ListView.builder(
                       itemCount: _faqs.length,
                       itemBuilder: (context, index) => faq_Card(title: _faqs[index].question.toString(), subTitle: _faqs[index].answer.toString())),
                 );}),
         ],
        ),
      ),
    );
  }
}
