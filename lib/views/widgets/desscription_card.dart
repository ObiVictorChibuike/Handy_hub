import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Descriptionard extends StatelessWidget {
  const Descriptionard({Key? key, this.date, this.desc, this.servicesRendered, this.elevation,}) : super(key: key);

  final String? desc, date, servicesRendered;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: white,
        elevation: elevation ?? 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: subHeaderText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              ReadMoreText(
                "$desc",
                trimLines: 3,
                style: subHeaderText.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w400),
                colorClickableText: primaryColor,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date Joined: $date",
                    style: subHeaderText.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Services rendered: $servicesRendered",
                    style: subHeaderText.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}



