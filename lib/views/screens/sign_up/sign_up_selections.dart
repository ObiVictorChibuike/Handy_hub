import 'package:esolink/logic/states/states_request.dart';
import 'package:esolink/views/screens/sign_up/customer_registration.dart';
import 'package:esolink/views/screens/sign_up/rider_registration.dart';
import 'package:esolink/views/screens/sign_up/service_provider_registration.dart';
import 'package:esolink/views/screens/sign_up/store_vendor_registration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/sign_up_selection_tile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../logic/registration/registration_bloc.dart';
import '../../../logic/services_category/services_request.dart';
import '../../../service_locator.dart';
import '../../constants/colors.dart';
import '../../constants/text_decoration.dart';
import '../sign_in/initial_sign_in.dart';

// ignore: must_be_immutable
class SignUpSelection extends StatelessWidget {
  RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();

  SignUpSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllCategories(context);
    getAllState(context); 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(
          children: [
            const AuthHeader(
              title: "Hello",
              subTitle: "How would you like to Register?",
            ),
            const SizedBox(
              height: 51,
            ),
            const SignUpSelectionTile(
              title: "Customer",
              subTitle:
                  "Personal account to pre-order or calculate farm produce ",
            ),
            const SignUpSelectionTile(
              title: "Service Provider",
              subTitle:
                  "Personal account to pre-order or calculate farm produce ",
            ),
            const SignUpSelectionTile(
              title: "Store Vendor",
              subTitle:
                  "Personal account to pre-order or calculate farm produce ",
            ),
            const SignUpSelectionTile(
              title: "Dispatch Rider",
              subTitle:
                  "Personal account to pre-order or calculate farm produce ",
            ),
            StreamBuilder<String>(
                stream: registrationBloc.userType,
                builder: (context, snapshot) {
                  print(snapshot.hasData);
                  return CustomButton(
                    enabled: snapshot.hasData ? true : false,
                    onTap: () {
                      snapshot.data == "Customer"
                          ? Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return CustomerRegistration();
                            }))
                          : snapshot.data == "Service Provider"
                              ? Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return ServiceProviderRegistration();
                                }))
                              : snapshot.data == "Store Vendor"
                                  ? Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                      return StoreVendorRegistration();
                                    }))
                                  : snapshot.data == "Dispatch Rider"
                                      ? Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                          return RiderRegistration();
                                        }))
                                      : null;
                    },
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
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const InitialSignIn();
                          }));
                        }),
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
          ],
        ),
      ),
    );
  }

 
}
