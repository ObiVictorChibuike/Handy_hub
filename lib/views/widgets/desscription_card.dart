import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

class Descriptionard extends StatelessWidget {
  const Descriptionard({Key? key, this.date, this.desc}) : super(key: key);

  final String? desc, date;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: white,
        elevation: 1.5,
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
              Text(
                "$desc",
                style: subHeaderText.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Text(
                "Date Joined: $date",
                style: subHeaderText.copyWith(
                    fontSize: 10, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}



