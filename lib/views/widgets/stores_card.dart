import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/store/stores_products.dart';
import 'package:flutter/material.dart';

class StoresCard extends StatelessWidget {
  const StoresCard({Key? key, this.stores, required this.height, required this.width}) : super(key: key);

  final StoresCategory? stores;
  final double height;
  final double width;
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
          // Container(
          //   height: 113 * .5,
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       gradient: LinearGradient(
          //           // begin: FractionalOffset.topCenter,
          //           // end: FractionalOffset.bottomCenter,
          //           colors: [
          //             Colors.white,
          //             Colors.white.withOpacity(.95),
          //           ], stops: const [
          //         0.0,
          //         1.0
          //       ])),
          // ),
          ShaderMask(
            shaderCallback: (Rect bounds){
              return LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent
                  ]).createShader(bounds);
            },
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff187226)),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${stores!.photoUrl}'))),
            ),
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
