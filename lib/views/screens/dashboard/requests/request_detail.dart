import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/views/widgets/custom_date.dart';
import 'package:esolink/views/widgets/desscription_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:esolink/views/widgets/photo_card.dart';
import 'package:flutter/material.dart';

import '../../../../models/request_model/request_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_decoration.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen(
      {Key? key, this.title, this.catID, this.requestsModel})
      : super(key: key);

  final String? title, catID;
  final RequestsModel? requestsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
          title: title,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              requestsModel!.photoUrl.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: primaryColor, width: 3)),
                                  child: Center(
                                      child: Text(
                                    requestsModel!.firstName![0],
                                    style: subHeaderText.copyWith(
                                        color: Colors.black),
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
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: grey),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                requestsModel!.category ?? "",
                                style: subHeaderText.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 10,
                              ),
                              Text(
                                "${requestsModel!.address}",
                                style: subHeaderText.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: grey),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                DescriptionCard(
                  date: CustomDate.slash(requestsModel!.createdOn.toString()),
                  desc: requestsModel!.description,
                ),
                const SizedBox(
                  height: 10,
                ),

                // FutureBuilder<List<BusinessPhoto>>(
                //     future: fetchBusinessPhotos(context, catID),
                //     builder: (context, snapshot) {

                //       while (snapshot.data!.isEmpty) {
                //         return Container();
                //       }
                //       return Row(children: [
                //         ...snapshot.data!.map(((e) {
                //           return PhotoCard(
                //             imageUrl: e.photoUrl,
                //           );
                //         })).toList()
                //       ]);
                //     }),

                // Visibility(
                //   visible:
                //       // ignore: unnecessary_null_comparison
                //       requestsModel!.businessPhoto! != [],
                //   child: Card(
                //       color: white,
                //       elevation: 1.5,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 16, vertical: 18),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             PhotoCard(
                //               // ignore: prefer_if_null_operators, unnecessary_null_comparison
                //               imageUrl: requestsModel!
                //                   .businessPhoto!
                //                   .toString().isEmpty ? "https://res.cloudinary.com/esolink/image/upload/v1644743449/engomb1fiyuul51ubmxq.jpg": requestsModel!.businessPhoto![0].photoUrl
                //                       .toString(),
                //             ),
                //             // PhotoCard(
                //             //   imageUrl: requestsModel!
                //             //       .businessPhoto![1].photoUrl
                //             //       .toString(),
                //             // ),
                //             // PhotoCard(
                //             //   imageUrl: requestsModel!
                //             //       .businessPhoto![2].photoUrl
                //             //       .toString(),
                //             // ),
                //             // PhotoCard(
                //             //   imageUrl: requestsModel!
                //             //       .businessPhoto![3].photoUrl
                //             //       .toString(),
                //             // ),
                //           ],
                //         ),
                //       )),
                // )
             
              ],
            ),
          )),
    );
  }
}
