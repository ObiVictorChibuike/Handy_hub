import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';
import '../screens/dashboard/requests/fetched_request.dart';

class AllCategoryCard extends StatelessWidget {
  const AllCategoryCard({Key? key, this.allCategory}) : super(key: key);

  final AllCategory? allCategory;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FetchedRequestScreen(
              id: allCategory!.categoryId.toString(),
              title: allCategory!.name);
        }));
      },
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 2,
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

                  child: Image.network(allCategory!.icon.toString()),

                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Flexible(
                child: Text(
                  "${allCategory!.name}",
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      fontSize: 14,
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
