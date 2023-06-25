import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void esoLinkBottomSheet({required List<Widget> children, required BuildContext context, required bool isDismissible, double? height}){
  Get.bottomSheet(
      Container(decoration:
      BoxDecoration(color: white,borderRadius: const
      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
        constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/3,),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: children,
          ),
        ),
    ), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
    isScrollControlled: true, isDismissible: isDismissible,
  );
}