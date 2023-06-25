import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_fields.dart';

class change_Password extends StatefulWidget {
  const change_Password({Key? key}) : super(key: key);

  @override
  State<change_Password> createState() => _change_PasswordState();
}

class _change_PasswordState extends State<change_Password> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPassword = TextEditingController();
  bool isObscuredOldPassword = true;
  bool isObscuredNewPassword = true;
  bool isObscuredConfirmPassword = true;
  final formKey = GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return Scaffold(
          appBar: AppBar(
              backgroundColor: white, elevation: 0.0,
              leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )),
              title: Text("Change Password",textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
          ),
          body: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 30,),
                Container(
                  height: MediaQuery.of(context).size.height * .435,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        PasswordField(
                          label: "Old Password",
                          hint: "******",
                          controller: oldPasswordController,
                          validator: (value){
                            if (value == null) {
                              return 'Please enter old password';
                            }
                            return null;
                          },
                        ),
                        PasswordField(
                          label: "New Password",
                          hint: "******",
                          controller: newPasswordController,
                          validator: (value){
                            if (value == null) {
                              return 'Please enter new password';
                            }
                            return null;
                          },
                        ),
                        PasswordField(
                          // obscuredText: isObscuredConfirmPassword,
                          label: "Confirm New Password",
                          hint: "******",
                          controller: confirmPassword,
                          validator: (value){
                            if (value == null) {
                              return 'Please enter old password';
                            } else if(value != newPasswordController.text){
                              return 'Password does not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    onTap: () {
                      if(formKey.currentState!.validate()){
                        controller.changePassword(oldPassword: oldPasswordController.text,
                            newPassword: newPasswordController.text, confirmPassword: confirmPassword.text
                        );
                      }
                    },
                    text: "Save",
                    enabled: oldPasswordController.text.isEmpty ||
                        newPasswordController.text.isEmpty ||
                        confirmPassword.text.isEmpty ? false : true,
                  ),
                ),
              ],
            ),
          )
      );
    });
  }
}
