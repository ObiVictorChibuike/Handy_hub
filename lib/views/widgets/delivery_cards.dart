import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/requests/request_detail.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({Key? key, this.color, this.deliveryStatus,
    this.deliveryId, this.goodsType, this.receiverName, this.pickUpLocation,
    this.deliveryDate, this.riderName, this.deliveryLocation, this.pickUpdate, this.senderName}) : super(key: key);

  final Color? color;
  final String? deliveryStatus;
  final String? deliveryId;
  final String? goodsType;
  final String? receiverName;
  final String? pickUpLocation;
  final String? deliveryDate;
  final String? riderName;
  final String? deliveryLocation;
  final String? pickUpdate;
  final String? senderName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        height: MediaQuery.of(context).size.height * .34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(deliveryId ?? '1629824592', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                    Text(goodsType ?? 'Perishable goods', style: TextStyle(fontSize: 11, color: Color(0XFF828282)),),
                    Text('from: ${senderName ?? "Shade Gbabson"}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(receiverName ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                        Text('Receiver', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                        SizedBox(height: 10,),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.save_as_outlined, size: 28, color: Color(0XFF187226),),
                    )
                  ],
                ),

              ],
            ),
          ),
          Divider(
            color: Color(0XFF828282),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Pick Up Location:', style: TextStyle(color: Color(0XFF828282), fontSize: 12),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 22,),
                  Text(pickUpLocation ?? '12, Garki Estate Leventus Ikeja Lagos'),
                  SizedBox(height: 6,),
                  Text(pickUpdate ?? '27 Dec 2021', style: TextStyle(color: Color(0XFF828282))),
                ],
              ),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Delivery Location:', style: TextStyle(color: Color(0XFF828282), fontSize: 12),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 22),
                  Text(deliveryLocation ?? '12, Garki Estate Leventus Ikeja Lagos'),
                  SizedBox(height: 6,),
                  Text(deliveryDate ?? '27 Dec 2021', style: TextStyle(color: Color(0XFF828282))),
                ],
              ),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Row(children: [
              TextButton(
                child: Text('Pay', style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  backgroundColor: Color(0XFF187226),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                },
              ),
            ],),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.0),
              ),
              color: this.color,
            ),
            height: 35,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Rider name: ${riderName ?? "Samuel"}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),),
                Text('Status: $deliveryStatus', style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700, ),),
              ],),
            ),)
        ]),
      ),
    );
  }
}
