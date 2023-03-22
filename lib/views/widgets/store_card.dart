import 'package:esolink/views/widgets/special_btn.dart';
import 'package:esolink/views/widgets/width_button.dart';
import 'package:flutter/material.dart';

import '../../models/stores_model/stores_model.dart';
import '../screens/dashboard/store/storeDetails.dart';

class storeCard extends StatelessWidget {
  const storeCard({Key? key, required this.stores}) : super(key: key);
  final Stores stores;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return storeDetailsScreen(
              id: stores.productId
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
            // border: Border(
            //     left: BorderSide(
            //         color: Color(0XFF187226)
            //     ),
            //     right: BorderSide(
            //         color: Color(0XFF187226)
            //     ),
            //     top: BorderSide(
            //         color: Color(0XFF187226)
            //     )
            // )
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1,), // changes position of shadow
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * .43,
        width: MediaQuery.of(context).size.width * .42,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(stores!.photoUrlList![0].photoUrl.toString()),fit: BoxFit.cover,)),
                ),
              ),
              Icon(Icons.favorite, color: Colors.grey,),
              Container(
                height: 70,
                  child: Text(stores!.description.toString())),
              Text('₦ ${stores!.amount.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('⭐⭐⭐⭐⭐', style: TextStyle(fontSize: 12)),
              SizedBox(height: 4,),
              // special_Btn(text: 'Add to cart',color1: const Color(0XFF187226),color2: Colors.white),
              widthButton(text: 'Add to Cart',)

            ],
          ),
        ),
      ),
    );
  }
}
