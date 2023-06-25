import 'package:esolink/logic/login/registration_controller.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../logic/registration/registration_request.dart';

// ignore: must_be_immutable
class ServiceProviderRegistration extends StatefulWidget {
  ServiceProviderRegistration({Key? key}) : super(key: key);

  @override
  State<ServiceProviderRegistration> createState() => _ServiceProviderRegistrationState();
}

class _ServiceProviderRegistrationState extends State<ServiceProviderRegistration> {
  final RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();

  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();

  final StateBloc stateBloc = locator.get<StateBloc>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final businessName = TextEditingController();
  final emailAddress = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final referralCode = TextEditingController();
  final address = TextEditingController();
  int? stateId;
  int? categoryId;
  bool? onSelectTermsAndCondition;
  _launchURL() async {
    final Uri url = Uri.parse('https://gethandyhub.com/#/terms');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    registrationBloc.addCustomerID(2);
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              const AuthHeader(
                title: "Service Provider",
                subTitle: "You are registering as a service provider",
              ),
              const SizedBox(
                height: 39,
              ),
              // PlainTextField(
              //   controller: firstName,
              //   label: "Name",
              //   hint: "",
              // ),
              // PlainTextField(
              //   controller: lastName,
              //   label: "Last Name",
              //   hint: "First Name",
              // ),
              PlainTextField(
                controller: businessName,
                label: "Business Name",
                hint: "",
              ),
              PlainTextField(
                controller: phoneNumber,
                label: "Phone",
                hint: "",
              ),
              PlainTextField(
                controller: emailAddress,
                label: "Email Address",
                hint: "",
              ),
              Align(alignment: Alignment.topLeft,
                child: Text("Type of Service",style: subHeaderText.copyWith(
                  fontSize: 15,
                )),
              ),
              const SizedBox(height: 10,),
              DropDownTextField(
                onChanged: (value) {
                  final index = controller.allCategoryResponse?.category?.indexWhere((element) => element.name == value.toString());
                  categoryId = controller.allCategoryResponse!.category![index!].categoryId;
                },
                items: controller.allCategoryResponse?.category?.map((item) => DropdownMenuItem<String>(
                  value: item.name ?? "",
                  child: Text("${item.name}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                )).toList(),
                title: "",
              ),
              const SizedBox(height: 25,),
              PlainTextField(
                controller: address,
                label: "Physical Address",
                hint: "23 Adegbite street, Sawmil, Ifako Ijaye",
              ),
              Align(alignment: Alignment.topLeft,
                child: Text("States of Residence",style: subHeaderText.copyWith(
                  fontSize: 15,
                )),
              ),
              const SizedBox(height: 10,),
              DropDownTextField(
                onChanged: (value) {
                  final index = controller.allStateResponse?.state?.indexWhere((element) => element.stateName == value.toString());
                  stateId = controller.allStateResponse!.state![index!].stateId;
                },
                items: controller.allStateResponse?.state?.map((item) => DropdownMenuItem<String>(
                  value: item.stateName ?? "",
                  child: Text("${item.stateName}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                )).toList(),
                title: "",
              ),
              const SizedBox(
                height: 25,
              ),
              PasswordField(
                label: "Password",
                controller: password,
                hint: "password",
              ),
              PlainTextField(
                controller: referralCode,
                label: "Referral Code[Optional]",
                hint: "",
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(primaryColor),
                        value: onSelectTermsAndCondition ?? false,
                        onChanged: (value){
                          setState(() {
                            onSelectTermsAndCondition = value;
                          });
                        }),
                    Expanded(child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "I have read, understood and I agree to HandyHub ",
                            style: subHeaderText.copyWith(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            )),
                        TextSpan(
                            text: "Privacy Policy,",
                            style: subHeaderText.copyWith(
                                color: primaryColor,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchURL();
                              }),
                        TextSpan(
                            text: " and ",
                            style: subHeaderText.copyWith(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            )),
                        TextSpan(
                            text: "Terms and conditions.",
                            style: subHeaderText.copyWith(
                                color: primaryColor,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () async {
                              _launchURL();
                            })
                      ]),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () async {
                  await controller.registerUser(
                      customerTypeId: 2,
                      firstName: businessName.text,
                      lastName: null,
                      phoneNumber: phoneNumber.text,
                      email: emailAddress.text,
                      businessName: businessName.text,
                      address: address.text,
                      categoryId: categoryId,
                      stateId: stateId!,
                      password: password.text,
                      referralCode: referralCode.text.isEmpty ? "" : referralCode.text,
                      termsAndCondition: onSelectTermsAndCondition
                  );
                },
                enabled:
                // firstName.text.isEmpty ||
                    // lastName.text.isEmpty ||
                    phoneNumber.text.isEmpty ||
                    emailAddress.text.isEmpty ||
                    address.text.isEmpty ||
                    password.text.isEmpty ||
                    businessName.text.isEmpty ||
                    onSelectTermsAndCondition == false ||
                    categoryId == null || stateId == null ? false : true,
                text: "Register",
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Already having an account?",
                        style: subHeaderText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xff4F4F4F),
                        )),
                    TextSpan(
                        text: "Login",
                        style: subHeaderText.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const InitialSignIn();
                                }));
                          }),
                  ]),
                ),
              )
              ,  const SizedBox(
                height: 12,
              ),
            ]),
          ),
        ),
      );
    });
  }
}
