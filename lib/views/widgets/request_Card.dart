import 'dart:developer';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/payment/request_payment_checkout.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/models/account/all_requested_services.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/special_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'bottom_sheet.dart';
import 'custom_date.dart';

class requests_Card extends StatefulWidget {
  final RequestedServices? requestedService;
  const requests_Card({Key? key, this.requestedService}) : super(key: key);

  @override
  State<requests_Card> createState() => _requests_CardState();
}

class _requests_CardState extends State<requests_Card> {
  final cardPaymentAmountController = TextEditingController();
  final walletPaymentAmountController = TextEditingController();
  final cashPaymentAmountController = TextEditingController();
  String? name;
  String? email;
  String? phoneNumber;
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

  showRequestDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Are you sure',
        content: 'Are you sure you want to make this request?',
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
  bool? loginStatus;
  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAuthUser();
      checkLoginStatus();
    });
    super.initState();
  }

  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    name = userDetails.serviceProviders![0].fullName;
    email = userDetails.serviceProviders![0].email;
    phoneNumber = userDetails.serviceProviders![0].phoneNumber;
  }

  showDeleteDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Are you sure?',
        content: 'Are you sure you want to delete this item? Accept to continue',
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

  final _controller = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    final buttonTitle = [
      "Delete",
      "Update Status"
    ];
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2),
            spreadRadius: 1, blurRadius: 1,
            offset: const Offset(1, 1,),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20), margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 60, width: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle,),
                  child: Image.network(widget.requestedService?.photoUrl ?? imagePlaceHolder),
                ),
              ),
              const SizedBox(height: 10,),
              Text(widget.requestedService?.jobStatusId == 1 ?
              'Pending' : widget.requestedService?.jobStatusId == 2 ? "Running" :
              widget.requestedService?.jobStatusId == 3 ? "Cancelled" : "Completed" ,
                style: TextStyle(fontSize: 12, color: widget.requestedService?.jobStatusId == 1 ?
                const Color(0xffFFDFB5) : widget.requestedService?.jobStatusId == 2 ? Colors.yellow :
                widget.requestedService?.jobStatusId == 3 ? Colors.red : Colors.green , fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(width: 15,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.requestedService?.serviceProvider ?? "", overflow: TextOverflow.fade,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                  widget.requestedService?.isVerified == true ? const Icon(Icons.verified, color: Color(0XFF187226),size: 16,) : const SizedBox(),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    glowColor:  const Color(0xffF2994A),
                    itemSize: 12,
                    initialRating: widget.requestedService?.rating ?? 0.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star, size: 12,
                      color: Color(0xffF2994A),
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                  Text("${widget.requestedService?.rating ?? 0} rating",
                    style: Theme.of(context).textTheme.bodyMedium?.
                    copyWith(fontSize: 9, fontWeight: FontWeight.w400, color: const Color(0xff4F4F4F)),),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.phone, size: 13,),
                  const SizedBox(width: 10,),
                  widget.requestedService?.phoneNumber2 == null ? const SizedBox() :
                  Text("${widget.requestedService?.phoneNumber2}".replaceRange(1, 6, "******"),
                    style: subHeaderText.copyWith(fontSize: 12, color: grey, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.calendar_month, size: 13,),
                  const SizedBox(width: 10,),
                  Text(CustomDate.slash(widget.requestedService?.createdOn.toString() ?? DateTime.now().toString()),
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.requestedService?.paymentStatus == true ? const SizedBox() :
                  special_Btn(text: 'Pay',color1: const Color(0XFF187226),color2: Colors.white, onTap: (){
                    esoLinkBottomSheet(
                        isDismissible: true,
                        children: [
                          const SizedBox(height: 8,),
                          Align(alignment: Alignment.topCenter,
                              child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                          const SizedBox(height: 18,),
                          Align(alignment: Alignment.topCenter,
                            child: Text("Select Payment Option", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: const Color(0xff4F4F4F), fontSize: 18),),
                          ),
                          const SizedBox(height: 10,),
                          GetBuilder<AccountController>(
                              init: AccountController(),
                              builder: (controller){
                                return  GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          Column(
                                            children: [
                                              const SizedBox(height: 8,),
                                              Align(alignment: Alignment.topCenter,
                                                  child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                              const SizedBox(height: 18,),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Align(alignment: Alignment.topRight,
                                                  child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                ),
                                              ),
                                              const Align(alignment: Alignment.centerLeft,
                                                  child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                              const SizedBox(height: 20,),
                                              PlainTextField(
                                                onChanged: (value){
                                                  log(walletPaymentAmountController.text);
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                keyboardType: TextInputType.number,
                                                controller: walletPaymentAmountController,
                                                label: "Enter Amount",
                                                hint: "Amount",
                                              ),
                                              const SizedBox(height: 15,),
                                              GestureDetector(
                                                onTap: (){
                                                  if (walletPaymentAmountController.text.isEmpty){
                                                    null;
                                                  }else{
                                                    Get.back();
                                                    controller.payFromWallet(amount: int.parse(walletPaymentAmountController.text),
                                                        requestId: widget.requestedService!.requestId!, context: context);
                                                  }
                                                },
                                                child: Container(
                                                  width: double.maxFinite,
                                                  height: 45, decoration: BoxDecoration(
                                                  color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                ),
                                                  child:Center(
                                                    child: Text(
                                                      "Continue",
                                                      style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                        context: context
                                    );
                                  },
                                  child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.wallet, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Wallet")
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const Divider(),
                          GetBuilder<AccountController>(
                              init: AccountController(),
                              builder: (controller){
                                return GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          StatefulBuilder(builder: (context, update){
                                            return Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Align(alignment: Alignment.topCenter,
                                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                                const SizedBox(height: 18,),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Align(alignment: Alignment.topRight,
                                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                  ),
                                                ),
                                                const Align(alignment: Alignment.centerLeft,
                                                    child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                const SizedBox(height: 20,),
                                                PlainTextField(
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  controller: cardPaymentAmountController,
                                                  label: "Enter Amount",
                                                  hint: "Amount",
                                                ),
                                                const SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: (){
                                                    if(cardPaymentAmountController.text.isEmpty){
                                                      null;
                                                    }else{
                                                      RequestPayWithCardPayment(encryptionKey, publicKey, cardPaymentAmountController.text,
                                                          email ?? "", widget.requestedService?.phoneNumber ?? phoneNumber ?? "", name ?? "", context, widget.requestedService!.requestId).chargeCard();
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 45, decoration: BoxDecoration(
                                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                  ),
                                                    child:Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                        context: context);
                                  },
                                  child: Container(width: double.maxFinite, height: 50,color: Colors.white,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.credit_card, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Direct Payment"),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const Divider(),
                          GetBuilder<AccountController>(
                              init: AccountController(),
                              builder: (controller){
                                return GestureDetector(
                                  onTap: (){
                                    Get.back();
                                    esoLinkBottomSheet(
                                        isDismissible: false,
                                        children: [
                                          StatefulBuilder(builder: (context, update){
                                            return Column(
                                              children: [
                                                const SizedBox(height: 8,),
                                                Align(alignment: Alignment.topCenter,
                                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                                const SizedBox(height: 18,),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Align(alignment: Alignment.topRight,
                                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                                  ),
                                                ),
                                                const Align(alignment: Alignment.centerLeft,
                                                    child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                const SizedBox(height: 20,),
                                                PlainTextField(
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.number,
                                                  controller: cashPaymentAmountController,
                                                  label: "Enter Amount",
                                                  hint: "Amount",
                                                ),
                                                const SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: (){
                                                    if(cashPaymentAmountController.text.isEmpty){
                                                      null;
                                                    }else{
                                                      Get.back();
                                                      controller.payFromCash(amount: int.parse(cashPaymentAmountController.text),
                                                        requestId: widget.requestedService!.requestId!,);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    height: 45, decoration: BoxDecoration(
                                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                  ),
                                                    child:Center(
                                                      child: Text(
                                                        "Continue",
                                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                        context: context);
                                  },
                                  child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.monetization_on, color: Color(0xff4F4F4F), size: 35,),
                                        SizedBox(width: 15,),
                                        Text("Cash")
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ], context: context);
                  },),
                  const SizedBox(width: 5,),
                  GetBuilder<AccountController>(
                      init: AccountController(),
                      builder: (controller){
                        double? rating;
                        return widget.requestedService?.hasRated == true ? const SizedBox() :
                        special_Btn(text: 'Rate',color1: Colors.white,color2: const Color(0XFF187226), onTap: (){
                          esoLinkBottomSheet(
                              isDismissible: true,
                              children: [
                                const SizedBox(height: 8,),
                                Align(alignment: Alignment.topCenter,
                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                const SizedBox(height: 18,),
                                Align(alignment: Alignment.topCenter,
                                  child: Text("How do you rate us?", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xff4F4F4F), fontSize: 18),),
                                ),
                                const SizedBox(height: 50,),
                                Align(alignment: Alignment.center,
                                  child: RatingBar.builder(
                                    glowColor:  const Color(0xffF2994A),
                                    itemSize: 30,
                                    initialRating: 0.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star, size: 30,
                                      color: Color(0xffF2994A),
                                    ),
                                    onRatingUpdate: (value) {
                                      rating = value;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                GestureDetector(
                                  onTap: (){
                                    if(rating == null){
                                      null;
                                    }else{
                                      Get.back();
                                      controller.rateUs(requestId: widget.requestedService!.requestId!, ratingNumber: rating!.toInt());
                                    }

                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 45, decoration: BoxDecoration(
                                    color: primaryColor, borderRadius: BorderRadius.circular(10),
                                  ),
                                    child:Center(
                                      child: Text(
                                        "Continue",
                                        style: subHeaderText.copyWith(fontSize: 13, color: white),
                                      ),
                                    ),
                                  ),
                                ),
                              ], context: context);
                        },);
                      }),
                  const SizedBox(width: 5,),
                  widget.requestedService?.jobStatusId == 4 ?
                  special_Btn(text: 'Request again',color1: Colors.white,color2: const Color(0XFF187226), onTap: () {
                    if (loginStatus == true){
                      showRequestDialog(onPressed: ()async{
                        Get.back();
                        await makeRequest(
                            categoryId: widget.requestedService!.categoryId!.toInt(),
                            serviceProviderId: widget.requestedService!.serviceProviderId!.toInt());
                      });
                    } else{
                      showAlertDialog(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                          }
                      );
                    }
                  },) : const SizedBox(),
                ],
              )
            ],
          ),
          const Spacer(),
          PopupMenuButton(
            child: const Icon(Icons.save_as_outlined, size: 20, color: Color(0XFF187226),),
            itemBuilder: (context) {
              return List.generate(buttonTitle.length, (index) {
                return PopupMenuItem(
                  child: Text(buttonTitle[index]),
                  onTap: (){
                    if(index == 0){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDeleteDialog(onPressed: (){
                          Get.back();
                          _controller.deleteRequest(requestId: widget.requestedService!.requestId!);
                        });
                      });
                    }else if(index == 1){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        esoLinkBottomSheet(
                            isDismissible: true,
                            children: [
                              const SizedBox(height: 8,),
                              Align(alignment: Alignment.topCenter,
                                  child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                              const SizedBox(height: 18,),
                              Align(alignment: Alignment.topCenter,
                                child: Text("Update Status", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xff4F4F4F), fontSize: 18),),
                              ),
                              const SizedBox(height: 10,),
                              GetBuilder<AccountController>(
                                  init: AccountController(),
                                  builder: (controller){
                                    return  GestureDetector(
                                      onTap: (){
                                        Get.back();
                                        controller.updateStatus(status: 1, requestId: widget.requestedService!.requestId!, name: widget.requestedService?.fullName ?? "");
                                      },
                                      child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                          child: Align(alignment: Alignment.centerLeft,
                                              child: Text("Pending", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                    );
                                  }),
                              const Divider(),
                              GetBuilder<AccountController>(
                                  init: AccountController(),
                                  builder: (controller){
                                    return  GestureDetector(
                                      onTap: (){
                                        Get.back();
                                        controller.updateStatus(status: 3, requestId: widget.requestedService!.requestId!, name: widget.requestedService?.fullName ?? "");
                                      },
                                      child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                          child: Align(alignment: Alignment.centerLeft,
                                              child: Text("Canceled", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                    );
                                  }),
                              const Divider(),
                              GetBuilder<AccountController>(
                                  init: AccountController(),
                                  builder: (controller){
                                    return  GestureDetector(
                                      onTap: (){
                                        Get.back();
                                        controller.updateStatus(status: 4, requestId: widget.requestedService!.requestId!, name: widget.requestedService?.fullName ?? "");
                                      },
                                      child: Container(width: double.maxFinite, height: 50, color: Colors.white,
                                          child: Align(alignment: Alignment.centerLeft,
                                              child: Text("Completed", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, ),))),
                                    );
                                  }),
                            ], context: context);
                      });
                    }
                  },
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
