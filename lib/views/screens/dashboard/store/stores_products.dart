import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

class StoresProduct extends StatelessWidget {
  StoresProduct({Key? key, this.id}) : super(key: key);
  final int? id;
  final StoresBLoc _storesBLoc = locator.get<StoresBLoc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        title: "Stores",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: FutureBuilder<List<Stores>>(
              future: fetchAllStoresByID(context, "$id"),
              builder: (context, snapshot) {
                while (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
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
    );
  }
}
