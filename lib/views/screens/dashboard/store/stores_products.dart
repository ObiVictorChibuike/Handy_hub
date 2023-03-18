import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

import '../../../widgets/store_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StoresProduct extends StatefulWidget {
  const StoresProduct({Key? key, this.id, this.title}) : super(key: key);
  final int? id;
  final String? title;

  @override
  State<StoresProduct> createState() => _StoresProductState();
}

class _StoresProductState extends State<StoresProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: PageWithBackButton(
        title: widget.title,
        body: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0, left: 22, right: 22),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.filter_alt, color: Color(0XFF187226),),
                          Text('Filters', style: TextStyle(color: Color(0XFF187226)),),
                        ],
                      ),
                      Text('|',style: TextStyle(color: Color(0XFF187226)),),
                      Row(
                        children: [
                          Icon(Icons.filter_list_outlined, color: Color(0XFF187226),),
                          Text('Sort', style: TextStyle(color: Color(0XFF187226)),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const storeCard()
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
                  child: FutureBuilder<List<Stores>>(
                      future: fetchAllStoresByID(context, "${widget.id}"),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.data!.isEmpty) {
                          return Center(child: Text('No Data in this category to Display', style: TextStyle(color: Colors.red),));
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
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 2.3, crossAxisCount: 2,mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_,index){
                            return storeCard(stores: snapshot.data![index]);
                          },
                        );
                        // return
                        // return storeCard();

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
