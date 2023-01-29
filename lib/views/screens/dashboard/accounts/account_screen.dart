import 'package:esolink/views/screens/dashboard/requested_Service.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_decoration.dart';
import '../../../icons/esolink_icons.dart';
import '../../../widgets/accountsCard.dart';
import '../../../widgets/page_with_back_button.dart';
import '../contact/contact.dart';
import '../faq/faqScreen.dart';
import '../inv-mgt/inventoryScreen.dart';
import '../jobs/jobs.dart';
import '../orders/ordersPage.dart';
import '../password/password.dart';
import '../profile/profile.dart';
import '../reminder/reminderScreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      backgroundColor: Color(0XFFE5E5E5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     TextFormField(
                //       decoration: InputDecoration(
                //           enabledBorder: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           filled: true,
                //           fillColor: white,
                //           hintText: "Search",
                //           hintStyle: subHeaderText.copyWith(
                //               color: const Color(0xffBDBDBD),
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400),
                //           prefixIcon: const Icon(Icons.search)),
                //     ),
                //     Text('1,200,000,000'),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('My Esolink Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'requested_service', text: 'Requested service', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return requested_Page();
                      }));
                },),
                accounts_Card(iconText: 'shopping-bag', text: 'Orders', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return orders_Page();
                      }));
                },),
                accounts_Card(iconText: 'jobs', text: 'Jobs', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return jobs_Page();
                      }));
                },),
                accounts_Card(iconText: 'inv_mgt', text: 'Inventory Management', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return inventory_Page();
                      }));
                },),
                accounts_Card(iconText: 'bells', text: 'Reminder', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return reminder_Page();
                      }));
                },),
                Padding(
                  padding: const EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('My Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'Active', text: 'Profile', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return profile_Screen();
                      }));
                },),
                accounts_Card(iconText: 'padlock', text: 'Change Password', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return change_Password();
                      }));
                },),
                Padding(
                  padding: const EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('About Esolink', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'question', text: 'FAQ', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return faq_Page();
                      }));
                },),
                accounts_Card(iconText: 'comments', text: 'Contact Us', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return contact_Page();
                      }));
                },),
                Padding(
                  padding: const EdgeInsets.only(bottom: 55.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    TextButton(onPressed: () {  }, child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600),),),
                  ],),
                )
              ],
            ),
          ),
        ),
    );
  }
}
