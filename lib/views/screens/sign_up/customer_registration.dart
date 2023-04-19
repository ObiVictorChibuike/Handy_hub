import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../logic/registration/registration_request.dart';
import '../sign_in/initial_sign_in.dart';

class CustomerRegistration extends StatelessWidget {
  CustomerRegistration({Key? key}) : super(key: key);
  final RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
  final StateBloc stateBloc = locator.get<StateBloc>();
  @override
  Widget build(BuildContext context) {
    registrationBloc.addCustomerID(1);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: SingleChildScrollView(
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
              stream: registrationBloc.firstName,
              onChanged: registrationBloc.addFirstName,
              label: "First Name",
              hint: "",
            ),
            PlainTextField(
              stream: registrationBloc.lastName,
              onChanged: registrationBloc.addLastName,
              label: "Last Name",
              hint: "",
            ),
            PlainTextField(
              stream: registrationBloc.phoneNumber,
              onChanged: registrationBloc.addPhone,
              label: "Business Name",
              hint: "",
            ),
            PlainTextField(
              stream: registrationBloc.email,
              onChanged: registrationBloc.addEmail,
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
              stream: registrationBloc.address,
              onChanged: registrationBloc.addAddress,
              label: "Physical Address",
              hint: "23 Adegbite street, Sawmil, Ifako Ijaye",
            ),
            StreamBuilder<List<StateModel>>(
                initialData: [
                  StateModel.fromJson(
                    {"stateId": 1, "countryId": 160, "stateName": "Abia"},
                  )
                ],
                stream: stateBloc.allStates,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isEmpty) {
                    return const SizedBox();
                  }
                  return StateField(
                    onchanged: registrationBloc.addState,
                    items2: snapshot.data!,
                    hint: "States of Residence",
                    label: "State of Residence",
                  );
                }),
            PasswordField(
              label: "Password",
              stream: registrationBloc.password,
              onchanged: registrationBloc.addPassword,
              hint: "password",
            ),
            PlainTextField(
              stream: registrationBloc.referralCode,
              onChanged: registrationBloc.addReferralCode,
              label: "Referral Code[Optional]",
              hint: "",
            ),
            const SizedBox(
              height: 10,
            ),
            TextCheckBox(
                stream: registrationBloc.termsAndCondition,
                onchanged: registrationBloc.addTermsAndConditions,
                text: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "I have read, understood and I agree to Esolink ",
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
                          ..onTap = () async {}),
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
                        recognizer: TapGestureRecognizer()..onTap = () async {})
                  ]),
                )),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<bool>(
                stream: registrationBloc.isSet,
                builder: (context, snapshot) {
                  return CustomButton(
                    onTap: () async {
                      await registerUser(context);
                    },
                    enabled: snapshot.data,
                    text: "Register",
                  );
                }),
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
  }
}
