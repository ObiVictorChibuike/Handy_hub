import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/product_details.dart';
import 'package:esolink/models/stores_model/store_response.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/back_button.dart';
import 'package:esolink/views/widgets/store_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/stores_model/stores_model.dart';
import '../../../widgets/page_with_back_button.dart';

class storeDetailsScreen extends StatefulWidget {
  const storeDetailsScreen({Key? key, required this.id, required this.stores}) : super(key: key);
  final int? id;
  final StoreProduct stores;

  @override
  State<storeDetailsScreen> createState() => _storeDetailsScreenState();
}

class _storeDetailsScreenState extends State<storeDetailsScreen> {

  final _ctrl = Get.put(StoreController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _ctrl.getProductDetails(id: widget.id!, context: context);
    });
    // fetchAllProductDetail(177);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
            centerTitle: true,
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )),
            title: Text("Details",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        resizeToAvoidBottomInset: true,
        body: StoreDetailsWidget(stores: widget.stores,),
      );
    });
  }
}
