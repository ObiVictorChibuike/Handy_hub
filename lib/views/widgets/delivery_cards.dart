import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/logic/payment/delivery_payment_checkout.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/delivery/edit_add_delivery.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bottom_sheet.dart';
import 'custom_date.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({Key? key, this.color, this.deliveryStatus,
    this.deliveryNumber, this.goodsType, this.receiverName, this.pickUpLocation,
    this.deliveryDate, this.riderName, this.deliveryLocation, this.pickUpdate,
    this.senderName, this.deliveryId, this.senderPhoneNumber, this.phoneNumber,
    this.distance, this.riderId, this.packageDetails, this.paymentStatus}) : super(key: key);

  final Color? color;
  final String? deliveryStatus;
  final String? distance;
  final String? senderPhoneNumber;
  final String? phoneNumber;
  final String? packageDetails;
  final String? deliveryNumber;
  final String? goodsType;
  final String? receiverName;
  final String? pickUpLocation;
  final String? deliveryDate;
  final String? riderName;
  final String? deliveryLocation;
  final String? pickUpdate;
  final String? senderName;
  final int? deliveryId;
  final int? riderId;
  final bool? paymentStatus;

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  String? name;
  String? email;
  String? phoneNumber;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAuthUser();
    });
    super.initState();
  }

  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    name = userDetails.serviceProviders![0].firstName;
    email = userDetails.serviceProviders![0].email;
    phoneNumber = userDetails.serviceProviders![0].phoneNumber;
  }
  final cardPaymentAmountController = TextEditingController();
  final walletPaymentAmountController = TextEditingController();
  final cashPaymentAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonTitle = [
      "Edit",
      "Delete",
      "Update Status"
    ];
    return GetBuilder<DeliveryController>(
      init: DeliveryController(),
        builder: (controller){
      return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2),
                spreadRadius: 1, blurRadius: 1,
                offset: const Offset(1, 1,),
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
              bottom: Radius.circular(40.0),
            ),
            color: Colors.white,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.deliveryNumber ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                      Text(widget.goodsType ?? '', style: const TextStyle(fontSize: 11, color: Color(0XFF828282)),),
                      Text('from: ${widget.senderName ?? ""}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),),
                    ],
                  ),
                  Row(
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.receiverName ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                          const Text('Receiver', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                        ],
                      ),
                      PopupMenuButton(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.save_as_outlined, size: 28, color: Color(0XFF187226),),
                        ),
                        itemBuilder: (context) {
                          return List.generate(buttonTitle.length, (index) {
                            return PopupMenuItem(
                              child: Text(buttonTitle[index]),
                              onTap: (){
                                if(index == 0){
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Get.to(()=> EditAddDelivery(
                                      nameOfSender: widget.senderName,
                                      senderPhoneNumber: widget.senderPhoneNumber,
                                      pickUpLocation: widget.pickUpLocation,
                                      receiverName: widget.receiverName,
                                      phoneNumber: widget.phoneNumber,
                                      deliveryId: widget.deliveryId,
                                      riderId: widget.riderId,
                                      deliveryLocation: widget.deliveryLocation,
                                      packageDetails: widget.packageDetails,
                                    ));
                                  });
                                }else if(index == 1){
                                  controller.removeDeliveryRecord(deliveryId: widget.deliveryId!, context: context);
                                }else{
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    esoLinkBottomSheet(
                                        isDismissible: true,
                                        children: [
                                          const SizedBox(height: 8,),
                                          Align(alignment: Alignment.topCenter,
                                              child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                          const SizedBox(height: 18,),
                                          Align(alignment: Alignment.topCenter,
                                            child: Text("Update Delivery Status", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: const Color(0xff4F4F4F), fontSize: 18),),
                                          ),
                                          const SizedBox(height: 10,),
                                          GetBuilder<DeliveryController>(
                                              init: DeliveryController(),
                                              builder: (controller){
                                                return  GestureDetector(
                                                  onTap: (){
                                                    Get.back();
                                                    controller.updateDeliveryStatus(deliveryStatus: 1, deliveryId: widget.deliveryId!, context: context);
                                                  },
                                                  child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                                      child: Align(alignment: Alignment.centerLeft,
                                                          child: Text("Pending", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                                );
                                              }),
                                          const Divider(),
                                          GetBuilder<DeliveryController>(
                                              init: DeliveryController(),
                                              builder: (controller){
                                                return  GestureDetector(
                                                  onTap: (){
                                                    Get.back();
                                                    controller.updateDeliveryStatus(deliveryStatus: 3, deliveryId: widget.deliveryId!, context: context);
                                                  },
                                                  child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                                      child: Align(alignment: Alignment.centerLeft,
                                                          child: Text("Cancelled", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                                );
                                              }),
                                          const Divider(),
                                          GetBuilder<DeliveryController>(
                                              init: DeliveryController(),
                                              builder: (controller){
                                                return  GestureDetector(
                                                  onTap: (){
                                                    Get.back();
                                                    controller.updateDeliveryStatus(deliveryStatus: 4, deliveryId: widget.deliveryId!, context: context);
                                                  },
                                                  child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                                      child: Align(alignment: Alignment.centerLeft,
                                                          child: Text("Delivered", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                                );
                                              }),
                                        ], context: context);
                                  });
                                }
                              },
                            );
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0XFF828282),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pick Up Location:', style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w700),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 22,),
                      Text(widget.pickUpLocation ?? '', style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6,),
                      Text(CustomDate.slash(widget.pickUpdate ?? DateTime.now().toString()), style: const TextStyle(color: Color(0XFF828282), fontSize: 10)),
                    ],
                  ),
                ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Location:', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 22),
                      Text(widget.deliveryLocation ?? '',style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6,),
                      Text(CustomDate.slash(widget.deliveryDate ?? DateTime.now().toString()), style: const TextStyle(color: Color(0XFF828282), fontSize: 10)),
                    ],
                  ),
                ],),
            ),
            widget.paymentStatus == false ? Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Row(children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    backgroundColor: const Color(0XFF187226),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    esoLinkBottomSheet(
                        isDismissible: true,
                        children: [
                          const SizedBox(height: 8,),
                          Align(alignment: Alignment.topCenter,
                              child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                          const SizedBox(height: 18,),
                          Align(alignment: Alignment.topCenter,
                            child: Text("Select Payment Option", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: const Color(0xff4F4F4F), fontSize: 18),),
                          ),
                          const SizedBox(height: 10,),
                          GetBuilder<DeliveryController>(
                              init: DeliveryController(),
                              builder: (controller){
                                return  GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          StatefulBuilder(builder: (context, update){
                                            return Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Align(alignment: Alignment.topCenter,
                                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                                const SizedBox(height: 18,),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Align(alignment: Alignment.topRight,
                                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                  ),
                                                ),
                                                const Align(alignment: Alignment.centerLeft,
                                                    child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                const SizedBox(height: 20,),
                                                PlainTextField(
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  controller: walletPaymentAmountController,
                                                  label: "Enter Amount",
                                                  hint: "Amount",
                                                ),
                                                const SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: (){
                                                    if(walletPaymentAmountController.text.isEmpty){
                                                      null;
                                                    }else{
                                                      Get.back();
                                                      controller.payFromWallet(amount: int.parse(walletPaymentAmountController.text), deliveryId: widget.deliveryId!);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 45, decoration: BoxDecoration(
                                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                  ),
                                                    child: Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ], context: context);
                                  },
                                  child: SizedBox(width: double.maxFinite, height: 50,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.wallet, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Wallet")
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const Divider(),
                          GetBuilder<DeliveryController>(
                              init: DeliveryController(),
                              builder: (controller){
                                return GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          StatefulBuilder(builder: (context, update){
                                            return Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Align(alignment: Alignment.topCenter,
                                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                                const SizedBox(height: 18,),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Align(alignment: Alignment.topRight,
                                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                  ),
                                                ),
                                                const Align(alignment: Alignment.centerLeft,
                                                    child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                const SizedBox(height: 20,),
                                                PlainTextField(
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  onChanged: (value){

                                                  },
                                                  controller: cardPaymentAmountController,
                                                  label: "Enter Amount",
                                                  hint: "Amount",
                                                ),
                                                const SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: (){
                                                    if(cardPaymentAmountController.text.isEmpty){
                                                      null;
                                                    }else{
                                                      DeliveryPayWithCardPayment(encryptionKey, publicKey, cardPaymentAmountController.text,
                                                          email ?? "", widget.phoneNumber ?? phoneNumber ?? "", name ?? "", context).chargeCard();
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 45, decoration: BoxDecoration(
                                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                  ),
                                                    child:Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ], context: context);
                                  },
                                  child: SizedBox(width: double.maxFinite, height: 50,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.credit_card, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Direct Payment"),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const Divider(),
                          GetBuilder<DeliveryController>(
                              init: DeliveryController(),
                              builder: (controller){
                                return GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          StatefulBuilder(builder: (context, update){
                                            return Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Align(alignment: Alignment.topCenter,
                                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                                const SizedBox(height: 18,),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Align(alignment: Alignment.topRight,
                                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                  ),
                                                ),
                                                const Align(alignment: Alignment.centerLeft,
                                                    child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                const SizedBox(height: 20,),
                                                PlainTextField(
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  controller: cashPaymentAmountController,
                                                  label: "Enter Amount",
                                                  hint: "Amount",
                                                ),
                                                const SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: (){
                                                    if(cashPaymentAmountController.text.isEmpty){
                                                      null;
                                                    }else{
                                                      Get.back();
                                                      controller.payFromCash(amount: int.parse(cashPaymentAmountController.text), deliveryId: widget.deliveryId!);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 45, decoration: BoxDecoration(
                                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                  ),
                                                    child:Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ], context: context);
                                  },
                                  child: SizedBox(width: double.maxFinite, height: 50,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.monetization_on, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Cash")
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ], context: context);
                  },
                  child: const Text('Pay', style: TextStyle(color: Colors.white),),
                ),
              ],),
            ) : const SizedBox(),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
                color: widget.color,
              ),
              height: 25,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rider name: ${widget.riderName ?? "Samuel"}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10),),
                    Text('Status: ${widget.deliveryStatus}', style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w700, ),),
                  ],),
              ),)
          ]),
        ),
      );
    });
  }
}
