import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/models/account/all_reminder_response.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/bottom_sheet.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/special_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'custom_date.dart';

class reminder_Card extends StatefulWidget {
  final Reminder? reminder;
  const reminder_Card({Key? key, this.reminder}) : super(key: key);

  @override
  State<reminder_Card> createState() => _reminder_CardState();
}

class _reminder_CardState extends State<reminder_Card> {
  final days = TextEditingController();
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

  showDismissDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Are you sure',
        content: 'Are you sure you want to dismiss this reminder?',
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

  String? name;
  String? email;
  String? phoneNumber;

  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    name = userDetails.serviceProviders![0].fullName;
    email = userDetails.serviceProviders![0].email;
    phoneNumber = userDetails.serviceProviders![0].phoneNumber;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAuthUser();
      checkLoginStatus();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final buttonTitle = [
      "Update Status"
    ];
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .21,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(17), topLeft: Radius.circular(17)),
                  color: widget.reminder?.reminderStatus == 1 ? const Color(0xffFFDFB5) : widget.reminder?.reminderStatus == 4 ? const Color(0xffADFFBA) : Colors.red ,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right:15,top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(CustomDate.getDate(widget.reminder?.reminderDate.toString() ?? DateTime.now().toString()), style: const TextStyle(color: Color(0XFF333333), fontSize: 12)),
                          Text(widget.reminder?.reminderStatus == 1 ? 'Pending': widget.reminder?.reminderStatus == 4 ? "Reminder" : "Reminder",
                            style: const TextStyle(fontSize: 10),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:80, top:10, bottom: 10.0),
                child: Row(
                  children: [
                    const Text('Service Category:', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 30,),
                    Expanded(child: Text(widget.reminder?.category ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:80, top:10, bottom: 10.0),
                child: Row(
                  children: [
                    const Text('Service Provider:', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 30,),
                    Expanded(child: Text(widget.reminder?.serviceProvider ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  special_Btn(text: 'Postpone',color1: const Color(0XFF187226),color2: Colors.white, onTap: (){
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
                                    child: Text("Postpone Reminder", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                const SizedBox(height: 20,),
                                PlainTextField(
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  controller: days,
                                  label: "Enter Number of Days",
                                  hint: "Days",
                                ),
                                const SizedBox(height: 15,),
                                GestureDetector(
                                  onTap: (){
                                    if(days.text.isEmpty){
                                      null;
                                    }else{
                                      Navigator.of(context).pop();
                                      controller.postpone(reminderId: widget.reminder!.reminderId!, days: int.parse(days.text));
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
                  },),
                  special_Btn(text: 'Request',color1: const Color(0XFF187226),color2: Colors.white, onTap: (){
                    if (loginStatus == true){
                      showRequestDialog(onPressed: ()async{
                        Get.back();
                        await makeRequest(categoryId: widget.reminder!.categoryId!.toInt(),
                            serviceProviderId: widget.reminder!.serviceProviderId!.toInt());
                      });
                    } else{
                      showAlertDialog(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                          }
                      );
                    }
                  },),
                  special_Btn(text: 'Dismiss',color1: const Color(0XFF187226),color2: Colors.white, onTap: (){
                    showDismissDialog(
                      onPressed: (){
                        Get.back();
                        controller.dismiss(reminderId: widget.reminder!.reminderId!);
                      }
                    );
                  },),
                ],
              ),

            ],
          ),
        ),
      );
    });
  }
}
