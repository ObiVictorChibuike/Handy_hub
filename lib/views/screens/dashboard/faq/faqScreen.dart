import 'package:esolink/views/widgets/faqCard.dart';
import 'package:flutter/material.dart';

class faq_Page extends StatelessWidget {
  const faq_Page({Key? key}) : super(key: key);

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
      body: Column(
       children: [
         SizedBox(height: 20,),
         faq_Card(title: 'What is Esolink', onTap: (){}),
         faq_Card(title: 'How does Esolink work if is sign up \n as a customer', onTap: (){}),
         faq_Card(title: 'How does Esolink work as a store vendor', onTap: (){}),
         faq_Card(title: 'How do i know that the result will meet my \n expectation', onTap: (){}),
         faq_Card(title: 'How much does each request for service costs?', onTap: (){}),
         faq_Card(title: 'What payment method can i use', onTap: (){}),
         faq_Card(title: 'What do i do if i am not satisfied \n with the services', onTap: (){}),
         faq_Card(title: 'What are the benefits of being on \n esolink platform as a service provider', onTap: (){}),
         faq_Card(title: 'What are the benefits of being on \n esolink platform as a vendor', onTap: (){}),
         faq_Card(title: 'What are the services available for request', onTap: (){}),
       ], 
      ),
    );
  }
}
