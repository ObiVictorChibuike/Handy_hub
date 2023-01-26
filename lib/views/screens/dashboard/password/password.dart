import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_fields.dart';

class change_Password extends StatelessWidget {
  const change_Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text('Change Password'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  PasswordField(
                    label: "Old Password",
                    hint: "******",
                  ),
                  PasswordField(
                    label: "New Password",
                    hint: "******",
                  ),
                  PasswordField(
                    label: "Confirm New Password",
                    hint: "******",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              onTap: () {
              },
              text: "Save",
            ),
          ),
        ],
      )
    );
  }
}
