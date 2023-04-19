import 'dart:developer';

import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/screens/dashboard/store/cart_page.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/store_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StoresProduct extends StatefulWidget {
  const StoresProduct({Key? key, this.id, this.title, this.imageUrl}) : super(key: key);
  final int? id;
  final String? title;
  final String? imageUrl;

  @override
  State<StoresProduct> createState() => _StoresProductState();
}

class _StoresProductState extends State<StoresProduct> {
  final _ctrl = Get.put(StoreController());
  bool? loginStatus;
  int? customerId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkLoginStatus();
      getAuthUser();
    });
    super.initState();
  }
  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    customerId = userDetails.serviceProviders![0].serviceProviderId;
  }

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    loginStatus == true ? _ctrl.getTotalCartItemInit(context: context) : null;
    log("finally !!!!");
    return isLoggedIn;
  }

  showAlertDialog({required void Function() onPressed}){
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
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: PageWithBackButton(
          title: widget.title,
          action: GestureDetector(
            onTap: (){
              log(loginStatus.toString());
              if(loginStatus == true ){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
              }else{
                showAlertDialog(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "store",)));
                    }
                );
              }
            },
            child: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 30,),
                GetBuilder<StoreController>(
                    init: StoreController(),
                    builder: (controller){
                      return Container(
                        height: 18, width: 18, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(40)),
                        child: Center(child: Text("${_ctrl.totalCartItemResponse?.cart?.cartList?.where((element) => element.quantity != 0).length ?? 0}",
                          style: Theme.of(context).textTheme.bodyLarge?.
                          copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),),),
                      );
                    })
              ],
            ),
          ),
          body: Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0, left: 22, right: 22),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.filter_alt, color: Color(0XFF187226),),
                            Text('Filters', style: TextStyle(color: Color(0XFF187226)),),
                          ],
                        ),
                        const Text('|',style: TextStyle(color: Color(0XFF187226)),),
                        Row(
                          children: const [
                            Icon(Icons.filter_list_outlined, color: Color(0XFF187226),),
                            Text('Sort', style: TextStyle(color: Color(0XFF187226)),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // const storeCard()
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
                    child: FutureBuilder<List<Stores>>(
                        future: fetchAllStoresByID(context, "${widget.id}"),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          } else if (snapshot.data!.isEmpty) {
                            return const Center(child: Text('No Data in this category to Display', style: TextStyle(color: Colors.red),));
                          }

                          // return Wrap(
                          //   direction: Axis.horizontal,
                          //   children: [
                          //     Expanded(
                          //       child: AddToCartCard(
                          //         stores: snapshot.data!.first,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       child: AddToCartCard(
                          //         stores: snapshot.data!.first,
                          //       ),
                          //     ),
                          //   ],
                          // );
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 2.5, crossAxisCount: 2,mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_,index){
                              return storeCard(stores: snapshot.data![index]);
                            },
                          );
                          // return
                          // return storeCard();

                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
