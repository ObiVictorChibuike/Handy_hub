import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/widgets/back_button.dart';
import 'package:esolink/views/widgets/delivery_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDeliveryScreen extends StatefulWidget {
  const AllDeliveryScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;

  @override
  State<AllDeliveryScreen> createState() => _AllDeliveryScreenState();
}

class _AllDeliveryScreenState extends State<AllDeliveryScreen> {
  // final RequestBLoc requestBLoc = locator.get<RequestBLoc>();
  final _ctrl = Get.put(DeliveryController());

  @override
  void initState() {
    _ctrl.fetchAllDelivery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryController>(
      init: DeliveryController(),
        builder: (controller){
      return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: EsolinkBackButton(),
                )),
            title: const Text('Delivery'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: controller.isLoadingAllDeliveryResponse == true ?
            const Center(child: CupertinoActivityIndicator()) :
                controller.isLoadingAllDeliveryResponse == false && controller.delivery!.isEmpty || controller.delivery == [] || controller.delivery == null ?
                Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                      Icon(Icons.event_note_outlined, color: primaryColor, size: 38,),
                      const SizedBox(height: 20,),
                      const Text("No delivery records", style: TextStyle(color: Colors.red),),
                      SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                    ],
                  ),
                ) : SingleChildScrollView(
                child: Column(
                children: List.generate(controller.delivery!.length, (index){
                  final item = controller.delivery;
                  return DeliveryCard(
                    deliveryDate: item?[index].createdBy.toString() ?? DateTime.now().toString(),
                    deliveryId: item?[index].transactionRef ?? "15WBFHJFDI",
                    goodsType: item?[index].packageDetails,
                    receiverName: item?[index].receiverName,
                    pickUpLocation: item?[index].pickupLocation,
                    deliveryLocation: item?[index].deliveryLocation,
                    riderName: item?[index].dispatchRider,
                    pickUpdate: item?[index].createdBy.toString() ?? DateTime.now().toString(),
                    senderName: item?[index].senderName,
                    deliveryStatus: item?[index].deliveryStatus == 1 ? "Pending" : item?[index].deliveryStatus == 2 ? "Completed" : "Pending",
                  );
                }),
              )
              // Column(children: [
              //   const SizedBox(height: 20,),
              //   DeliveryCard(color: Color(0XFFFFDFB5), text: 'Pending',),
              //   DeliveryCard(color: Color(0XFFADFFBA), text: 'Completed',),
              //   DeliveryCard(color: Color(0XFFFFDFB5), text: 'Pending',)
              // ],),
            ),
          )
      );
    });
  }
}
