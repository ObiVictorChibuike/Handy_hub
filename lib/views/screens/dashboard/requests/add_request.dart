import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  bool? loginStatus;
  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }


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
  final _ctrl = Get.find<AccountController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top:90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const EsolinkIcons(
                icons: "delivery_1",
                size: 300,
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () {
                    loginStatus == true ? _ctrl.switchTab() :
                    showAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "request",)));
                        });
                  },
                  text: "Make a request",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
