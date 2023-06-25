import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/orderCard.dart';
import 'ordersPage.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({Key? key}) : super(key: key);

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  final _ctrl = Get.put(AccountController());

  @override
  void initState() {
    _ctrl.fetchAllOrder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
            backgroundColor: white, elevation: 0.0,
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
            title: Text("Orders",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        body:  controller.isLoadingAllOrderResponse == true ?
        const Center(child: CupertinoActivityIndicator()) :
        controller.isLoadingAllOrderResponse == false && controller.order!.isEmpty || controller.order == [] || controller.order == null ?
        const orders_Page() : RefreshIndicator(
          onRefresh: ()async{
            await _ctrl.fetchAllOrder();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(controller.order!.length, (index){
                final item = controller.order?[index];
                return order_Card(
                  order: item,
                );
              })
            ],
          ),
        ),
      );
    });
  }
}
