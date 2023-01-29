import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/request_model/request_model.dart';
import '../../../widgets/delivery_cards.dart';
import '../../../widgets/page_with_back_button.dart';
import '../../../widgets/returned_requests_card.dart';

class allDeliveryScreen extends StatelessWidget {
  allDeliveryScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;
  // final RequestBLoc requestBLoc = locator.get<RequestBLoc>();
  // final MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text('Delivery'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 20,),
                DeliveryCard(color: Color(0XFFFFDFB5), text: 'Pending',),
                DeliveryCard(color: Color(0XFFADFFBA), text: 'Completed',),
                DeliveryCard(color: Color(0XFFFFDFB5), text: 'Pending',)
              ],),
            ),
          )
        );
  }
}
