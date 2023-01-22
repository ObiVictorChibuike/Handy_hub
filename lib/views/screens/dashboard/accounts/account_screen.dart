import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_decoration.dart';
import '../../../icons/esolink_icons.dart';
import '../../../widgets/page_with_back_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        automaticallyImplyLeading: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: white,
                          hintText: "Search",
                          hintStyle: subHeaderText.copyWith(
                              color: const Color(0xffBDBDBD),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  Text('1,200,000,000'),
                  const EsolinkIcons(
                    icons: "card",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('My Esolink Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "requested_service",
                  size: 20,
                ),
                dense: true,
                title: Text('Requested Service'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "shopping-bag",
                  size: 20,
                ),
                dense: true,
                title: Text('Orders'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "jobs",
                  size: 20,
                ),
                dense: true,
                title: Text('Jobs'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "inv_mgt",
                  size: 20,
                ),
                dense: true,
                title: Text('Inventory Management'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "bells",
                  size: 20,
                ),
                dense: true,
                title: Text('Reminder'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('My Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "Active",
                  size: 20,
                ),
                dense: true,
                title: Text('Profile'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "padlock",
                  size: 20,
                ),
                dense: true,
                title: Text('Change Password'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('About Esolink', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "question",
                  size: 20,
                ),
                dense: true,
                title: Text('FAQ'),
              ),
              ListTile(
                leading: const EsolinkIcons(
                  icons: "comments",
                  size: 20,
                ),
                dense: true,
                title: Text('Contact Us'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextButton(onPressed: () {  }, child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600),),),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
