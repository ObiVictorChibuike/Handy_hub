import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/requests/request_detail.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ReturnedRequestCard extends StatefulWidget {
  ReturnedRequestCard({Key? key, this.serviceProviders,}) : super(key: key);

  final RequestModelList? serviceProviders;

  @override
  State<ReturnedRequestCard> createState() => _ReturnedRequestCardState();
}

class _ReturnedRequestCardState extends State<ReturnedRequestCard> {
  MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();

  bool? loginStatus;
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }

  showAlertDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Create Account/SignIn',
        content: 'To carry out further operations, you are required to create an account. If you already have an account, please sign in with your account credentials.',
        backgroundColor:  primaryColor,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'Accept',
            textColor: primaryColor,
            onPressed: onPressed,
          ),
          CleanDialogActionButtons(
            actionTitle: 'Cancel',
            textColor: const Color(0xffbe3a2c),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return RequestDetailsScreen(
                  serviceProviders: widget.serviceProviders,
                  title: widget.serviceProviders!.firstName,
                  businessName: widget.serviceProviders?.businessName,
                );
              }));
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        widget.serviceProviders!.photoUrl.toString(),
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
                                  widget.serviceProviders!.firstName![0],
                              style: subHeaderText.copyWith(color: Colors.black),
                            )),
                          );
                        },
                      ),
                    ),
                  ),
                  widget.serviceProviders?.isOnline == true ?
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 13, width: 13,
                      decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                    ),
                  ) :  const SizedBox()
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.serviceProviders!.firstName}", overflow: TextOverflow.ellipsis,
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
                          "${widget.serviceProviders!.phoneNumber}"
                              .replaceRange(1, 6, "******"),
                          style: subHeaderText.copyWith(
                              fontSize: 12,
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
                          "${widget.serviceProviders!.distance}",
                          style: subHeaderText.copyWith(
                              fontSize: 12,
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
                        RatingBar.builder(
                          itemSize: 12,
                          initialRating: widget.serviceProviders?.rating?.toDouble() ?? 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star, size: 9,
                            color: Color(0xffF2994A),
                          ),
                          onRatingUpdate: (rating) {
                            if (kDebugMode) {
                              print(rating);
                            }
                          },
                        ),
                        Text("(${widget.serviceProviders?.rating ?? 0} rating)",
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 9, fontWeight: FontWeight.w400, color: const Color(0xff4F4F4F)),),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return RequestDetailsScreen(
                                    serviceProviders: widget.serviceProviders,
                                    title: widget.serviceProviders!.firstName,
                                    businessName: widget.serviceProviders?.businessName,
                                  );
                                }));
                          },
                          child: Container(
                            height: 31,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            width: 72,
                            child: Center(
                              child: Text(
                                "Preview",
                                style: subHeaderText.copyWith(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 21,),
                        GestureDetector(
                          onTap: () async {
                            loginStatus == true ?
                            await makeRequest(
                            categoryId: widget.serviceProviders!.categoryId!.toInt(),
                            serviceProviderId: widget.serviceProviders!.serviceProviderId!.toInt())
                            :   showAlertDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "category",)));
                                }
                            );

                          },
                          child: Container(
                            height: 31,
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(5)),
                            width: 72,
                            child: Center(
                              child: Text(
                                "Request",
                                style: subHeaderText.copyWith(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              widget.serviceProviders!.isVerified == true ?
              Icon(Icons.verified, color: primaryColor, size: 15,)
                  : const SizedBox()
            ]),
          ),
        ),
      ),
    );
  }
}
