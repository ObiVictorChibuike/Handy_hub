import 'package:flutter/material.dart';

import '../../../widgets/jobCard.dart';

class jobs_Page extends StatelessWidget {
  const jobs_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Jobs',
          style: TextStyle(color: Colors.black,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          jobs_Card(),
          jobs_Card(),
          jobs_Card(),
        ],
      ),
    );
  }
}
