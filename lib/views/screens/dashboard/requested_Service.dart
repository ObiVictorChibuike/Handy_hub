import 'package:flutter/material.dart';

import '../../widgets/request_Card.dart';

class requested_Page extends StatelessWidget {
  const requested_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text('Requested Services'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color(0XFFF8F8F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text('Completed / Cancelled', style: TextStyle(fontSize: 17)),
              ),
              requests_Card(),
              requests_Card(),
              requests_Card(),
              requests_Card(),
              requests_Card(),
              requests_Card(),
            ],
          ),
        ),
      ),
    );
  }
}
