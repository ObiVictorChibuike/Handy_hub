import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../icons/esolink_icons.dart';
import '../../../widgets/custom_button.dart';

class orders_Page extends StatelessWidget {
  const orders_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: white, elevation: 0.0,
      //     leading: GestureDetector(
      //         onTap: (){
      //           Navigator.of(context).pop();
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
      //             child: const Icon(
      //               Icons.arrow_back_ios_new_rounded,
      //               color: Colors.black,
      //               size: 20,
      //             ),
      //           ),
      //         )),
      //     title: Text("Orders",textAlign: TextAlign.center,
      //         style: subHeaderText.copyWith(
      //             color: Colors.black,
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold))
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: Column(
            children: [
              const EsolinkIcons(
                icons: "delivery_1",
                size: 380,
              ),
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () {
                  },
                  text: "Place an Order",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
