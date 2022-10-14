import 'package:esolink/views/screens/sign_up/customer_registration.dart';
import 'package:esolink/views/screens/sign_up/service_provider_registration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/sign_up_selection_tile.dart';
import 'package:flutter/material.dart';

import '../../../logic/registration/registration_bloc.dart';
import '../../../service_locator.dart';

class SignUpSelection extends StatelessWidget {
  const SignUpSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();
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
            const Spacer(),
            StreamBuilder<String>(
                stream: registrationBloc.userType,
                builder: (context, snapshot) {
                  return CustomButton(
                    enabled: snapshot.hasData,
                    onTap: () {
                      snapshot.data == "Customer"
                          ? Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return const CustomerRegistration();
                            }))
                          : snapshot.data == "Service Provider"
                              ? Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return const ServiceProviderRegistration();
                                }))
                              : null;
                    },
                    text: "Register",
                  );
                }),
          ],
        ),
      ),
    );
  }
}
