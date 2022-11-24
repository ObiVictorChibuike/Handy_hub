import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

class StoresProduct extends StatelessWidget {
  const StoresProduct({Key? key, this.id}) : super(key: key);
  final int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        title: "Stores",
        body: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
            child: FutureBuilder<List<Stores>>(
                future: fetchAllStoresByID(context, "$id"),
                builder: (context, snapshot) {
                  while (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // return Wrap(
                  //   direction: Axis.horizontal,
                  //   children: [
                  //     Expanded(
                  //       child: AddToCartCard(
                  //         stores: snapshot.data!.first,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: AddToCartCard(
                  //         stores: snapshot.data!.first,
                  //       ),
                  //     ),
                  //   ],
                  // );
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 15, crossAxisSpacing: 5,
                    children: [
                      ...snapshot.data!
                          .map((e) => AddToCartCard(
                                stores: e,
                              ))
                          .toList()
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
