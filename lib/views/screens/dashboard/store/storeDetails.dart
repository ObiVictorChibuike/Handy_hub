import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/product_details.dart';
import 'package:flutter/material.dart';

import '../../../../models/stores_model/stores_model.dart';
import '../../../widgets/page_with_back_button.dart';

class storeDetailsScreen extends StatefulWidget {
  const storeDetailsScreen({Key? key, required this.id}) : super(key: key);
  final int? id;

  @override
  State<storeDetailsScreen> createState() => _storeDetailsScreenState();
}

class _storeDetailsScreenState extends State<storeDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    fetchAllProductDetail(177);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: PageWithBackButton(
        title: 'Details',
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<ProductDetails>>(
                future: fetchAllProductDetail(widget.id!),
              builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No Data in this category to Display', style: TextStyle(color: Colors.red),));
                  }

                  return Column(
                    children: [
                      Text(snapshot.data![0].product.toString()),
                    ],
                  );
              }
            ),
          ),
        ),
      ),
    );
  }
}
