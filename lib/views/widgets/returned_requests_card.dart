import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/requests/request_detail.dart';
import 'package:flutter/material.dart';

class ReturnedRequestCard extends StatelessWidget {
  ReturnedRequestCard({
    Key? key,
    this.requestsModel,
  })
      : super(key: key);

  final RequestsModel? requestsModel; 
  MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    requestsModel!.photoUrl.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor, width: 3)),
                        child: Center(
                            child: Text(
                          requestsModel!.firstName![0],
                          style: subHeaderText.copyWith(color: Colors.black),
                        )),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${requestsModel!.firstName}",
                  style: subHeaderText.copyWith(
                      fontSize: 14, color: grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const EsolinkIcons(
                      size: 6,
                      icons: "phone",
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "${requestsModel!.phoneNumber}"
                          .replaceRange(1, 6, "******"),
                      style: subHeaderText.copyWith(
                          fontSize: 8,
                          color: grey,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const EsolinkIcons(
                      size: 6,
                      icons: "location",
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "${requestsModel!.distance}",
                      style: subHeaderText.copyWith(
                          fontSize: 8,
                          color: grey,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xffF2994A),
                      size: 9,
                    ),
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xffF2994A),
                      size: 9,
                    ),
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xffF2994A),
                      size: 9,
                    ),
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xffF2994A),
                      size: 9,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Color(0xffF2994A),
                      size: 9,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RequestDetailsScreen(
                            requestsModel: requestsModel,
                            title: requestsModel!.firstName, 
                          );
                        }));
                      },
                      child: Container(
                        height: 21,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        width: 56,
                        child: Center(
                          child: Text(
                            "Preview",
                            style: subHeaderText.copyWith(
                                fontSize: 10,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 21,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RequestDetailsScreen(
                            requestsModel: requestsModel,
                            title: requestsModel!.firstName, 
                          );
                        }));
                      },
                      child: Container(
                        height: 21,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        width: 56,
                        child: Center(
                          child: Text(
                            "Request",
                            style: subHeaderText.copyWith(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
