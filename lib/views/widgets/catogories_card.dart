import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({Key? key, this.categoriesModel}) : super(key: key);

  final CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 14),
        elevation: 5,
        color: white,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(categoriesModel!.icon.toString()),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              "${categoriesModel!.name}",
              style: subHeaderText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff4F4F4F)),
            )
          ],
        ));
  }
}
