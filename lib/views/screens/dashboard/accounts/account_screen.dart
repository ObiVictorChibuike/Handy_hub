import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/views/screens/dashboard/requested_Service.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../widgets/accountsCard.dart';
import '../contact/contact.dart';
import '../faq/faqScreen.dart';
import '../inv-mgt/inventoryScreen.dart';
import '../jobs/jobs.dart';
import '../orders/ordersPage.dart';
import '../password/password.dart';
import '../profile/profile.dart';
import '../reminder/reminderScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  bool? loginStatus;
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }

  showSignOutAlertDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Log Out',
        content: 'Are you sure you want sign out of HandyHub?',
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

  showSignInAlertDialog({required void Function() onPressed}){
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: const Color(0XFFE5E5E5),
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
                const Padding(
                  padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('My HandyHub Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'requested_service', text: 'Requested service', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const requested_Page();
                      }));
                },),
                accounts_Card(iconText: 'shopping-bag', text: 'Orders', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const orders_Page();
                      }));
                },),
                accounts_Card(iconText: 'jobs', text: 'Jobs', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const jobs_Page();
                      }));
                },),
                accounts_Card(iconText: 'inv_mgt', text: 'Inventory Management', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const inventory_Page();
                      }));
                },),
                accounts_Card(iconText: 'bells', text: 'Reminder', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const reminder_Page();
                      }));
                },),
                const Padding(
                  padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('My Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'Active', text: 'Profile', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const profile_Screen();
                      }));
                },),
                accounts_Card(iconText: 'padlock', text: 'Change Password', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const change_Password();
                      }));
                },),
                const Padding(
                  padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                  child: Text('About HandyHub', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ),
                accounts_Card(iconText: 'question', text: 'FAQ', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const faq_Page();
                      }));
                },),
                accounts_Card(iconText: 'comments', text: 'Contact Us', onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const contact_Page();
                      }));
                },),
                Padding(
                  padding: const EdgeInsets.only(bottom: 55.0, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    TextButton(onPressed: () {
                      showSignOutAlertDialog(onPressed: () {
                        if(loginStatus == true){
                          progressIndicator(context);
                          Future.delayed(const Duration(seconds: 5),() async {
                            Get.put<LocalCachedData>(await LocalCachedData.create());
                            await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: false).then((value) async {
                              await LocalCachedData.instance.clearCache();
                              Get.back();
                              Get.offAll(const InitialSignIn());
                            });
                          });
                        }else{
                          showSignInAlertDialog(onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "category",)));
                          });
                        }
                      });
                    }, child: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600),),),
                  ],),
                )
              ],
            ),
          ),
        ),
    );
  }
}
