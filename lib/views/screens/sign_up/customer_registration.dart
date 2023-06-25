import 'package:esolink/logic/login/registration_controller.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/logic/registration/registration_validation.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../logic/registration/registration_request.dart';
import '../sign_in/initial_sign_in.dart';

class CustomerRegistration extends StatefulWidget {
  CustomerRegistration({Key? key}) : super(key: key);

  @override
  State<CustomerRegistration> createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
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
  bool? onSelectTermsAndCondition;

  _launchURL() async {
    final Uri url = Uri.parse('https://gethandyhub.com/#/terms');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    registrationBloc.addCustomerID(1);
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
                title: "Customer",
                subTitle: "You are registering as a Customer",
              ),
              const SizedBox(
                height: 39,
              ),
              PlainTextField(
                controller: firstName,
                label: "First Name",
                hint: "",
              ),
              PlainTextField(
                controller: lastName,
                label: "Last Name",
                hint: "",
              ),
              PlainTextField(
                controller: phoneNumber,
                label: "Phone Number",
                hint: "",
              ),
              // PlainTextField(
              //   controller: businessName,
              //   label: "Business Name",
              //   hint: "",
              // ),
              PlainTextField(
                controller: emailAddress,
                label: "Email Address",
                hint: "",
              ),
              // StreamBuilder<List<CategoriesModel>>(
              //     initialData: [
              //       CategoriesModel.fromJson(
              //         {
              //           "categoryId": 14,
              //           "name": " Architect",
              //           "icon":
              //               "https://res.cloudinary.com/esolink/image/upload/v1641928046/ikbniod9u9l4narj50aj.png",
              //           "publicId": null,
              //           "description": " Architect",
              //           "supervisorName": "Fortune Johnbull",
              //           "supervisorEmail": "goodyrhome@gmail.com ",
              //           "supervisorNumber": "2349056309508",
              //           "group": "B",
              //           "active": null,
              //           "deleted": null,
              //           "createdBy": null,
              //           "createdOn": null,
              //           "updatedBy": null,
              //           "updatedOn": null
              //         },
              //       )
              //     ],
              //     stream: categoriesBloc.allCategories,
              //     builder: (context, snapshot) {
              //       if (snapshot.data != null && snapshot.data!.isEmpty) {
              //         return const SizedBox();
              //       }
              //       return CategoryField(
              //         stream: registrationBloc.categoryID,
              //         onchanged: registrationBloc.addCatgoryID,
              //         value: snapshot.data.toString(),
              //         items: snapshot.data!
              //             .map<dynamic>((CategoriesModel? e) => e)
              //             .toList(),
              //         hint: "Select Service Category",
              //         label: "Type of Service",
              //       );
              //     }),
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
              // StreamBuilder<List<StateModel>>(
              //     initialData: [
              //       StateModel.fromJson(
              //         {"stateId": 1, "countryId": 160, "stateName": "Abia"},
              //       )
              //     ],
              //     stream: stateBloc.allStates,
              //     builder: (context, snapshot) {
              //       if (snapshot.data != null && snapshot.data!.isEmpty) {
              //         return const SizedBox();
              //       }
              //       return StateField(
              //         onchanged: registrationBloc.addState,
              //         items2: snapshot.data!,
              //         hint: "States of Residence",
              //         label: "State of Residence",
              //       );
              //     }),
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
                      customerTypeId: 1,
                      firstName: firstName.text,
                      lastName: lastName.text,
                      phoneNumber: phoneNumber.text,
                      email: emailAddress.text,
                      businessName: firstName.text,
                      address: address.text,
                      categoryId: 0,
                      stateId: stateId!,
                      password: password.text,
                      referralCode: referralCode.text.isEmpty ? "" : referralCode.text,
                      termsAndCondition: onSelectTermsAndCondition
                  );
                },
                enabled: firstName.text.isEmpty ||
                    lastName.text.isEmpty ||
                    phoneNumber.text.isEmpty ||
                    emailAddress.text.isEmpty ||
                    address.text.isEmpty ||
                    password.text.isEmpty ||
                    onSelectTermsAndCondition == false ||
                    stateId == null ? false : true,
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
              ),
              const SizedBox(
                height: 12,
              ),
            ]),
          ),
        ),
      );
    });
  }
}
