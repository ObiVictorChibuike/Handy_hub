import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/views/screens/dashboard/accounts/vendor/vendor_product_page.dart';
import 'package:esolink/views/screens/dashboard/jobs/jobs.dart';
import 'package:esolink/views/screens/dashboard/orders/ordersList.dart';
import 'package:esolink/views/screens/dashboard/reminder/reminderList.dart';
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
import '../password/password.dart';
import '../profile/profile.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
  final _controller = Get.put(AccountController());
  AuthUserResponse? authUserResponse;
  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.fetchUserDetails().then((value){
      authUserResponse = value;
    });
    setState(() {});
  }
  bool? loginStatus;

  @override
  void initState() {
    checkLoginStatus();
    _controller.getAllRequestedServices();
    getAuthUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Account'),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              backgroundColor: const Color(0XFFE5E5E5),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                      child: Text('My HandyHub Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
                    accounts_Card(iconText: 'requested_service', text: 'Requested service', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const requested_Page();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    accounts_Card(iconText: 'shopping-bag', text: 'Orders', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const AllOrder();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    authUserResponse?.serviceProviders?[0].customerTypeId != 3 ?
                    accounts_Card(iconText: 'jobs', text: 'Jobs', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const jobs_Page();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },) :
                    accounts_Card(iconText: 'jobs', text: 'Products', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const VendorProductPage();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    // accounts_Card(iconText: 'inv_mgt', text: 'Inventory Management', onTap: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //         return const inventory_Page();
                    //       }));
                    // },),
                    accounts_Card(iconText: 'bells', text: 'Reminder', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const reminder_List();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    const Padding(
                      padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                      child: Text('My Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
                    accounts_Card(iconText: 'Active', text: 'Profile', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const profile_Screen();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    accounts_Card(iconText: 'padlock', text: 'Change Password', onTap: () {
                      if(loginStatus == true){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const change_Password();
                            }));
                      }else{
                        showSignInAlertDialog(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
                        });
                      }
                    },),
                    const Padding(
                      padding: EdgeInsets.only(left:15.0, top: 15.0, bottom: 15.0),
                      child: Text('About HandyHub', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
                    accounts_Card(iconText: 'question', text: 'Frequently Asked Questions', onTap: () {
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
                    loginStatus == true ? Padding(
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
                    ) : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
