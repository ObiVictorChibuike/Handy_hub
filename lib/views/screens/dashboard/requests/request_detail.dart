import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/custom_date.dart';
import 'package:esolink/views/widgets/desscription_card.dart';
import 'package:esolink/views/widgets/images_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

import '../../../../models/request_model/request_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_decoration.dart';
import '../../../widgets/custom_button.dart';

class RequestDetailsScreen extends StatelessWidget {
  RequestDetailsScreen({Key? key, this.title, this.catID, this.requestsModel})
      : super(key: key);

  final String? title, catID;
  final RequestsModel? requestsModel;
  final MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();
  @override
  Widget build(BuildContext context) { 
    makeRequestBloc.addCategoryID(requestsModel!.categoryId);
    makeRequestBloc.addEmail(requestsModel!.email);
    makeRequestBloc.addPhone(requestsModel!.phoneNumber);
    makeRequestBloc.addFullName(requestsModel!.firstName);
    makeRequestBloc.addLocale(requestsModel!.address);
    makeRequestBloc.addServiceID(requestsModel!.serviceProviderId);
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
                Descriptionard(
                  date: CustomDate.slash(requestsModel!.createdOn.toString()),
                  desc: requestsModel!.description,
                ),
                const SizedBox(
                  height: 10,
                ),

                const ImageCard(),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomButton(
                    onTap: () async {
                      await makeRequest(context);
                    },
                    text: "Make a Request",
                  ),
                ) 
              ],
            ),
          )),
    );
  }
}
