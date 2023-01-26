import 'package:flutter/material.dart';

import '../../../widgets/inventoryCard.dart';

class inventory_List extends StatelessWidget {
  const inventory_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
          'Inventory',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          inventory_Card(),
          inventory_Card(),
          inventory_Card(),
        ],
      ),
    );
  }
}
