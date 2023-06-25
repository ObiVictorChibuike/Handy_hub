import 'package:esolink/logic/delivery/delivery_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddDelivery extends StatefulWidget {
  final String? nameOfSender;
  final String? senderPhoneNumber;
  final String? pickUpLocation;
  final String? packageDetails;
  final String? receiverName;
  final String? phoneNumber;
  final int? deliveryId;
  final int? riderId;
  final String? deliveryLocation;

  const EditAddDelivery({Key? key, this.nameOfSender, this.senderPhoneNumber,
    this.pickUpLocation, this.receiverName, this.phoneNumber, this.deliveryId,
    this.riderId, this.deliveryLocation, this.packageDetails,}) : super(key: key);

  @override
  State<EditAddDelivery> createState() => _EditAddDeliveryState();
}

class _EditAddDeliveryState extends State<EditAddDelivery> {
  final _controller = Get.put(DeliveryController());
  final nameOfSender = TextEditingController();
  final senderPhoneNumber = TextEditingController();
  final pickUpLocation = TextEditingController();
  final receiverName = TextEditingController();
  final receiverPhoneNumber = TextEditingController();
  final rider = TextEditingController();
  @override
  void initState() {
    nameOfSender.text = widget.nameOfSender ?? "";
    senderPhoneNumber.text = widget.senderPhoneNumber ?? "";
    pickUpLocation.text = widget.pickUpLocation ?? "";
    receiverName.text = widget.receiverName ?? "";
    receiverPhoneNumber.text = widget.phoneNumber ?? "";
    _controller.getAllRiders();
    super.initState();
  }
  int? index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryController>(
        init: DeliveryController(),
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
                    subTitle: "Make changes to your delivery request details",
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
                      setState(() {
                        index = controller.allRiderResponseModel?.serviceProviders?.indexWhere((element) => element.fullName == value.toString());
                        rider.text = "${controller.allRiderResponseModel?.serviceProviders?[index!].fullName} ${controller.allRiderResponseModel?.serviceProviders?[index!].distance}";
                      });
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
                  CustomButton(
                    onTap: () {
                      controller.editDeliveryRequest(deliveryId: widget.deliveryId!,
                          senderName: nameOfSender.text, senderPhoneNumber: senderPhoneNumber.text,
                          pickupLocation: pickUpLocation.text, receiverName: receiverName.text,
                          phoneNumber: receiverPhoneNumber.text, deliveryLocation: widget.deliveryLocation ?? "",
                          packageDetails: widget.packageDetails ?? "", riderId: widget.riderId, context: context);
                    },
                    enabled: nameOfSender.text.isNotEmpty && senderPhoneNumber.text.isNotEmpty &&
                        pickUpLocation.text.isNotEmpty && receiverName.text.isNotEmpty && receiverPhoneNumber.text.isNotEmpty
                    && rider.text.isNotEmpty ? true : false,
                    text: "Send",
                  ),
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
