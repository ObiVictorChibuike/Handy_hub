import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class AddToCartCard extends StatelessWidget {
  const AddToCartCard({Key? key, this.stores}) : super(key: key);
  final Stores? stores;
  @override
  Widget build(BuildContext context) {
    print(stores!.photoUrlList![0].photoUrl.toString());
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: Image.asset(
          "assets/images/prod.png",
          width: 100,
          height: 100,
        ),
      ),
      const Icon(
        Icons.favorite,
        color: Color(0xffBDBDBD),
      ),
      const SizedBox(height: 9),
      Container(
        constraints: const BoxConstraints(maxHeight: 57, maxWidth: 350),
        child: Text(
          stores!.description ??
              "15 Hand Cream With SPF For Summers That Are A Must-Have",
              textAlign: TextAlign.left,
          style: subHeaderText.copyWith(
              color: grey, fontSize: 12, fontWeight: FontWeight.w400),
        ),
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
      Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Add to Cart",
            style: subHeaderText.copyWith(fontSize: 13, color: white),
          ),
        ),
      ),
      const SizedBox(
        height: 12,
      )
    ]);
  }
}
