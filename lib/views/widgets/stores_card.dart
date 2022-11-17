import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/store/stores_products.dart';
import 'package:flutter/material.dart';

class StoresCard extends StatelessWidget {
  const StoresCard({Key? key, this.stores}) : super(key: key);

  final StoresCategory? stores;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return StoresProduct(
            id: stores!.categoryId,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
        child: Stack(children: [
          Container(
            height: 113 * .5,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    // begin: FractionalOffset.topCenter,
                    // end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(.95),
                    ], stops: const [
                  0.0,
                  1.0
                ])),
          ),
          Container(
            height: 113,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xff187226).withOpacity(.65)),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/car.png"))),
          ),
          Positioned(
            bottom: 5,
            left: 15,
            child: Text(
              "${stores!.name}",
              style: subHeaderText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff4F4F4F)),
            ),
          ),
        ]),
      ),
    );
  }
}
