import 'package:flutter/material.dart';

import '../../../widgets/orderCard.dart';

class orders_List extends StatelessWidget {
  const orders_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          order_Card(),
          order_Card(),
          order_Card(),
        ],
      ),
    );
  }
}
