import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class AddToCartCard extends StatelessWidget {
  const AddToCartCard({Key? key, this.stores}) : super(key: key);
  final Stores? stores;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
          height: 8,
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/prod.png",
                  fit: BoxFit.fitHeight,
                  height: 100,
                  width: 100,
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    // color: valueDarkBlue,
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.transparent,
                          Colors.transparent
                        ]),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Icon(
            Icons.favorite,
            size: 12,
            color: Color(0xffBDBDBD),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          stores!.name ?? "15 Hand Cream",
          textAlign: TextAlign.left,
          style: subHeaderText.copyWith(
              color: grey, fontSize: 12, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 6,
        ),
        Text("₦ ${stores!.amount ?? ""}",
            style: subHeaderText.copyWith(
                color: const Color(0xff333333),
                fontSize: 12,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 6,
        ),

        ElevatedButton(
            onPressed: () {},
            child: Text("Add to Cart",
                style: subHeaderText.copyWith(fontSize: 13, color: white)))

        // Container(
        //   width: double.infinity,
        //   height: 46,
        //   decoration: BoxDecoration(
        //       color: primaryColor, borderRadius: BorderRadius.circular(10)),
        //   child: Center(
        //     child: Text(
        //       "Add to Cart",
        //       style: subHeaderText.copyWith(fontSize: 13, color: white),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}

class AddingToCart extends StatelessWidget {
  const AddingToCart({Key? key, this.categoriesModel}) : super(key: key);

  final Stores? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 3,
          color: white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/images/prod.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Flexible(
                child: Text(
                  "${categoriesModel!.name}",
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff4F4F4F)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          )),
    );
  }
}
