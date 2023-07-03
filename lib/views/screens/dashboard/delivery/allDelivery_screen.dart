import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/views/widgets/delivery_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_delivery.dart';
import 'delivery_screen.dart';

class AllDeliveryScreen extends StatefulWidget {
  const AllDeliveryScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;

  @override
  State<AllDeliveryScreen> createState() => _AllDeliveryScreenState();
}

class _AllDeliveryScreenState extends State<AllDeliveryScreen> {
  bool? loginStatus;
  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }
  final _ctrl = Get.put(DeliveryController());

  @override
  void initState() {
    checkLoginStatus();
    _ctrl.fetchAllDelivery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryController>(
      init: DeliveryController(),
        builder: (controller){
      return Scaffold(
          floatingActionButton: controller.delivery!.isEmpty || controller.delivery == [] || controller.delivery == null ?
        const SizedBox() :
        FloatingActionButton(onPressed: (){
          Get.to(()=> const AddDelivery());
        }, child: const Icon(Icons.add, color: Colors.white,),),
          appBar: AppBar(
            // leading: GestureDetector(
            //     onTap: (){
            //       Navigator.of(context).pop();
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.all(18.0),
            //       child: EsolinkBackButton(),
            //     )),
            title: const Text('Delivery'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: RefreshIndicator(
            onRefresh: ()async{
              await _ctrl.fetchAllDelivery();
            },
            child: SafeArea(
              child: controller.isLoadingAllDeliveryResponse == true ?
              const Center(child: CupertinoActivityIndicator()) :
                  controller.isLoadingAllDeliveryResponse == false && controller.delivery!.isEmpty || controller.delivery == [] || controller.delivery == null ?
                  const DeliveryScreen()
                  : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                  child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    ...List.generate(controller.delivery!.length, (index){
                      final item = controller.delivery;
                      return DeliveryCard(
                        color: item?[index].deliveryStatus == 1 ? const Color(0xffFFDFB5) : item?[index].deliveryStatus == 2 ? Colors.yellow :
                        item?[index].deliveryStatus == 3 ? Colors.red : const Color(0xffADFFBA),
                        deliveryDate: item?[index].createdOn.toString(),
                        deliveryNumber: item?[index].deliverNumber ?? "",
                        goodsType: item?[index].packageDetails,
                        receiverName: item?[index].receiverName,
                        pickUpLocation: item?[index].pickupLocation,
                        deliveryLocation: item?[index].deliveryLocation,
                        riderName: item?[index].dispatchRider,
                        pickUpdate: item?[index].createdOn.toString(),
                        senderName: item?[index].senderName,
                        deliveryStatus: item?[index].deliveryStatus == 1 ? "Pending" : item?[index].deliveryStatus == 2 ? "Running" :
                        item?[index].deliveryStatus == 3 ? "Cancelled" : "Completed",
                        deliveryId: item?[index].deliveryId,
                        senderPhoneNumber: item?[index].senderPhoneNumber,
                        phoneNumber: item?[index].phoneNumber,
                        riderId: item?[index].riderId,
                        packageDetails: item?[index].packageDetails,
                        paymentStatus: item?[index].paymentStatus
                      );
                    }),
                  ]
                )
              ),
            ),
          )
      );
    });
  }
}
