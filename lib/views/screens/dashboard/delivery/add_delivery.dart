import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDelivery extends StatefulWidget {
  const AddDelivery({Key? key}) : super(key: key);

  @override
  State<AddDelivery> createState() => _AddDeliveryState();
}

class _AddDeliveryState extends State<AddDelivery> {
  final nameOfSender = TextEditingController();
  final senderPhoneNumber = TextEditingController();
  final pickUpLocation = TextEditingController();
  final receiverName = TextEditingController();
  final receiverPhoneNumber = TextEditingController();
  final rider = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryController>(
        init: Get.find<DeliveryController>(),
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
                title: Text("Delivery",textAlign: TextAlign.center,
                    style: subHeaderText.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const AuthHeader(
                    title: "Delivery Request",
                    subTitle: "Create a new delivery request details",
                  ),
                  const SizedBox(
                    height: 39,
                  ),
                  PlainTextField(
                    controller: nameOfSender,
                    label: "Name Of Sender",
                    hint: "",
                  ),
                  PlainTextField(
                    controller: senderPhoneNumber,
                    label: "Sender Phone Number",
                    hint: "",
                  ),
                  PlainTextField(
                    controller: pickUpLocation,
                    label: "Pick Up Location",
                    hint: "",
                  ),
                  PlainTextField(
                    controller: receiverName,
                    label: "Receiver Name",
                    hint: "",
                  ),
                  PlainTextField(
                    controller: receiverPhoneNumber,
                    label: "Receiver Phone Number",
                    hint: "",
                  ),
                  Align(alignment: Alignment.topLeft,
                    child: Text("Rider",style: subHeaderText.copyWith(
                      fontSize: 15,
                    )),
                  ),
                  const SizedBox(height: 10,),
                  DropDownTextField(
                    onChanged: (value) {
                      final index = controller.allRiderResponseModel?.serviceProviders?.indexWhere((element) => element.fullName == value.toString());
                      rider.text = controller.allRiderResponseModel!.serviceProviders![index!].serviceProviderId!.toString();
                    },
                    items: controller.allRiderResponseModel?.serviceProviders?.map((item) => DropdownMenuItem<String>(
                      value: item.fullName ?? "",
                      child: Text("${item.fullName} ${item.distance}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                    )).toList(),
                    title: "",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: (){
                      if(nameOfSender.text.isNotEmpty && senderPhoneNumber.text.isNotEmpty &&
                          pickUpLocation.text.isNotEmpty && receiverName.text.isNotEmpty && receiverPhoneNumber.text.isNotEmpty
                          && rider.text.isNotEmpty ){
                        controller.addDeliveryRequest(senderName: nameOfSender.text,
                            senderPhoneNumber: senderPhoneNumber.text,
                            pickupLocation: pickUpLocation.text,
                            receiverName: receiverName.text, phoneNumber: receiverPhoneNumber.text,
                            deliveryLocation: pickUpLocation.text, packageDetails: "",
                            riderId: int.parse(rider.text), context: context);
                      }else{
                        null;
                      }
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("Send", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, ),),),
                    ),
                  ),
                  // CustomButton(
                  //   onTap: () {
                  //
                  //   },
                  //   enabled: ? true : false,
                  //   text: "Send",
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
