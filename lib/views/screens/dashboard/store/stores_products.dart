import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

class StoresProduct extends StatefulWidget {
  const StoresProduct({Key? key, this.id, this.title}) : super(key: key);
  final int? id;
  final String? title;

  @override
  State<StoresProduct> createState() => _StoresProductState();
}

class _StoresProductState extends State<StoresProduct> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        title: widget.title,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.filter_alt),
                          Text('Filters', style: TextStyle(color: ),),
                        ],
                      ),
                      Text('|'),
                      Row(
                        children: [
                          Icon(Icons.filter_list_outlined),
                          Text('Sort'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
                  child: FutureBuilder<List<Stores>>(
                      future: fetchAllStoresByID(context, "${widget.id}"),
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
                          mainAxisSpacing: 140, crossAxisSpacing: 5,
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
            ],
          ),
        ),
      ),
    );
  }
}
