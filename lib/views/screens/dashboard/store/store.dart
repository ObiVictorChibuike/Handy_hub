import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart'; 
import '../../../widgets/stores_card.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key? key}) : super(key: key);

  final StoresBLoc storesBLoc = locator.get<StoresBLoc>();
  @override
  Widget build(BuildContext context) {
    fetchAllStoresCategories(context);
    return Scaffold(
      body: PageWithBackButton(
        title: "Stores",
        automaticallyImplyLeading: false,
        action: const Icon(Icons.search),
        body: StreamBuilder<List<StoresCategory>>(
            stream: storesBLoc.storesCategories,
            builder: (context, snapshot) {
              while (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    ...snapshot.data!.map((e) {
                      return StoresCard(stores: e);
                    }).toList()
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
