import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/accounts/vendor/Add_product.dart';
import 'package:esolink/views/screens/dashboard/accounts/vendor/edit_product.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class VendorProductPage extends StatefulWidget {
  const VendorProductPage({Key? key}) : super(key: key);

  @override
  State<VendorProductPage> createState() => _VendorProductPageState();
}

class _VendorProductPageState extends State<VendorProductPage> {
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
  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }
  bool? loginStatus;
  final _controller = Get.put(AccountController());

  @override
  void initState() {
    checkLoginStatus();
    _controller.getAllVendorProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
        final buttonTitle = [
          "Edit",
          "Delete"
        ];
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          if(loginStatus == true){
            Get.to(()=> const AddProduct());
          }else{
            showSignInAlertDialog(onPressed: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "account",)));
            });
          }
        }, child: const Icon(Icons.add, color: Colors.white,),),
        appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )),
            title: Text("Products",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        body: _controller.hasProduct == false && _controller.vendorProduct!.isEmpty ||
            _controller.vendorProduct == [] && _controller.vendorProduct == null ?
            const Center(
              child: CupertinoActivityIndicator(),
            ) : _controller.hasProduct == true && _controller.vendorProduct!.isEmpty ||
            _controller.vendorProduct == [] && _controller.vendorProduct == null ?
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/2.5,),
              Icon(Icons.propane_tank_rounded, color: primaryColor, size: 38,),
              const SizedBox(height: 20,),
              Text('No Product record', style: TextStyle(color: primaryColor),),
              SizedBox(height: MediaQuery.of(context).size.height/2.5,),
            ],
          ),
        ) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.9, crossAxisCount: 2, mainAxisSpacing: 10,
                  crossAxisSpacing: 10,),
                itemCount: controller.vendorProduct!.length,
                itemBuilder: (context,index){
                  final item = controller.vendorProduct![index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(1, 1,), // changes position of shadow
                        ),
                      ],
                    ),
                    // height: MediaQuery.of(context).size.height * .43,
                    width: MediaQuery.of(context).size.width * .42,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12,bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(alignment: Alignment.topRight,
                            child: PopupMenuButton(
                              child: const Icon(Icons.more_vert_outlined, size: 18, color: Color(0XFF187226),),
                              itemBuilder: (context) {
                                return List.generate(buttonTitle.length, (index) {
                                  return PopupMenuItem(
                                    child: Text(buttonTitle[index], style: Theme.of(context).textTheme.bodyLarge?.copyWith(),),
                                    onTap: (){
                                      if(index == 0){
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          Get.to(()=> EditProduct(productName: item.name ?? "",
                                            productDescription: item.description ?? "",
                                            productAmount: item.amount.toString(),
                                            imageUrl: item.photoUrlList,
                                            productId: item.productId!.toInt(),
                                            categoryId: item.categoryId!.toInt(),
                                            productCategory: item.categoryName,
                                            status: item.active,
                                          ));
                                        });
                                      }else if(index == 1){
                                        controller.deleteProduct(productId: item.productId!.toString());
                                      }
                                    },
                                  );
                                });
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 150,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: item.photoUrlList == null || item.photoUrlList!.isEmpty || item.photoUrlList == [] ?
                                         const NetworkImage(imagePlaceHolder) :
                                        NetworkImage(item.photoUrlList![0].photoUrl.toString()),fit: BoxFit.cover,)),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Text(item.vendorName.toString(), overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff4F4F4F))),
                              const SizedBox(height: 5,),
                              Text(item.description.toString(), overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff4F4F4F))),
                              const SizedBox(height: 5,),
                              Text('₦ ${MoneyFormatter(amount: item.amount?.toDouble() ?? 0.00).output.nonSymbol}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
