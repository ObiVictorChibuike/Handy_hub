
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/account/all_response_response.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import 'custom_date.dart';

class order_Card extends StatelessWidget {
  final Order? order;
  const order_Card({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoneyFormatter formatWalletBalance = MoneyFormatter(
        amount: order?.amount?.toDouble() ?? 0.00
    );
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .17,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2),
              spreadRadius: 1, blurRadius: 1,
              offset: const Offset(1, 1,),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(16),
                      child: Container(height: 80, width: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                          child: Image.network(order?.photoUrlList?[0].photoUrl ?? imagePlaceHolder)),
                    ),
                    Text(order?.deliveryStatus == 1 ?
                    'Pending' : order?.deliveryStatus == 2 ? "Running" :
                    order?.deliveryStatus == 3 ? "Cancelled" : "Completed" , style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: primaryColor, fontSize: 10),),
                    Text(CustomDate.slash(order?.createdOn.toString() ?? DateTime.now().toString()), style: const TextStyle(color: Color(0XFF828282), fontSize: 10)),
                  ],
                ),
              ),
              const SizedBox(width: 15,),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${order?.productName }", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff4F4F4F), fontSize: 12),),
                    // Text('Variation: ${order?.productDescription}'),
                    Row(
                      children: [
                        Text('Order No: ',  
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff4F4F4F), fontSize: 12),),
                        Text(order?.orderNumber ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.
                            copyWith(color: const Color(0xff4F4F4F), fontSize: 12, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Row(
                      children: [
                        Text('QTY ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff4F4F4F), fontSize: 12),),
                        Text("${order?.quantity ?? 1}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff4F4F4F), fontSize: 12, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Text('N${formatWalletBalance.output.nonSymbol}',
                        style: const TextStyle(color: Color(0XFF219653), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
