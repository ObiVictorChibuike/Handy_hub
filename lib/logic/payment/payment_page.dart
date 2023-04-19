import 'dart:developer';

import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


class PayWithCardPayment{
  final String encryptionKey;
  final String publicKey;
  final String amount;
  final String email;
  final String phoneNumber;
  final String fullName;
  final BuildContext context;
  PayWithCardPayment(this.encryptionKey, this.publicKey, this.amount, this.email, this.phoneNumber, this.fullName, this.context);

  String _getReference() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  chargeCard() async {
    final ctrl = Get.put(StoreController());
    final Flutterwave flutterWave = Flutterwave(
        context: context,
        publicKey: publicKey,
        currency: "NGN",
        redirectUrl: 'https://facebook.com',
        txRef: _getReference(),
        amount: amount,
        customer: Customer(email: email, name: fullName, phoneNumber: phoneNumber),
        paymentOptions: "card",
        //"card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Payment", description: "Payment for an item with card", logo: "assets/images/logo.png"),
        isTestMode: false
    );

    try{
      final ChargeResponse response = await flutterWave.charge();
      if (response.success!) {
        ctrl.cardCheckOut(txRef: response.txRef!, context: context);
        // showErrorSnackBar(context,
        //     title: "Something Went Wrong",
        //     content: "Payment Success");
        print("${response.toJson()}");
      } else {
        showErrorSnackBar(context,
            title: "Something Went Wrong",
            content: response.status ?? "Invalid request");
      }
    }catch (error){
      log(error.toString());
    }
  }
}

