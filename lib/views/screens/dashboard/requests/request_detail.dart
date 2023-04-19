import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/back_button.dart';
import 'package:esolink/views/widgets/custom_date.dart';
import 'package:esolink/views/widgets/custom_scroll_physics.dart';
import 'package:esolink/views/widgets/desscription_card.dart';
import 'package:esolink/views/widgets/images_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:esolink/views/widgets/view_profile_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../models/request_model/request_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_decoration.dart';
import '../../../widgets/custom_button.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key, this.title, this.serviceProviders, this.businessName}) : super(key: key);
  final String? title;
  final String? businessName;
  final ServiceProvider? serviceProviders;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();
  bool? loginStatus;
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
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

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white, elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: EsolinkBackButton(),
            )),
        title: Text(widget.title!,textAlign: TextAlign.center,
            style: subHeaderText.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold))
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
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
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  ViewProfileImage(imageUrl: widget.serviceProviders?.photoUrl.toString() ?? imagePlaceHolder,)));
                            },
                            child: Image.network(
                              widget.serviceProviders?.photoUrl.toString() ?? imagePlaceHolder,
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
                                        widget.serviceProviders!.firstName![0],
                                        style: subHeaderText.copyWith(
                                            color: Colors.black),
                                      )),
                                );
                              },
                            ),
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
                          "${widget.serviceProviders!.firstName}",
                          style: subHeaderText.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.serviceProviders!.category ?? "",
                              style: subHeaderText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: grey),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            RatingBar.builder(
                              itemSize: 12, initialRating: 1.0,
                              minRating: 1, direction: Axis.horizontal,
                              allowHalfRating: true, itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(Icons.star, size: 9, color: Color(0xffF2994A),),
                              onRatingUpdate: (rating) {
                                if (kDebugMode) {
                                  print(rating);
                                }
                              },
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
                              "${widget.serviceProviders!.address}",
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
                  elevation: 0.0,
                  date: CustomDate.slash(widget.serviceProviders?.createdOn.toString() ?? DateTime.now().toString()),
                  desc: widget.serviceProviders?.description == "null" ? "No description records" :
                  widget.serviceProviders?.description ?? "No description records",
                  servicesRendered: "${widget.serviceProviders?.servicesRendered ?? 0.toString()}"
              ),
              const SizedBox(
                height: 10,
              ),
              ImageCard(serviceProviders: widget.serviceProviders),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(alignment: Alignment.centerLeft,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location",   style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.serviceProviders?.address ?? "",  style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: grey),),
                      const Divider(),
                      Text("Date joined",   style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(CustomDate.slash(widget.serviceProviders?.createdOn.toString() ?? DateTime.now().toString()),  style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: grey),),
                      const Divider(),
                      Text("Last seen",   style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(CustomDate.slash(widget.serviceProviders?.lastSeen.toString() ?? DateTime.now().toString()),  style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: grey),),
                      const Divider(),
                      Text("Status",   style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Verified",  style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: grey),),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CustomButton(
                  onTap: ()async{
                    loginStatus == true ?
                    await makeRequest(context, fullName: widget.businessName ?? widget.title ?? "",
                        email: widget.serviceProviders?.email ?? "", phoneNumber: widget.serviceProviders?.phoneNumber ?? "",
                        categoryId: widget.serviceProviders!.categoryId!.toInt(),
                        location: widget.serviceProviders?.address ?? "", serviceProviderId: widget.serviceProviders!.serviceProviderId!.toInt()) :
                    showAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "category",)));
                        }
                    );
                  },
                  text: "Make a Request",
                ),
              ),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      )
    );
  }
}
