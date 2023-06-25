import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/stores_model/store_response.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/widgets/width_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:money_formatter/money_formatter.dart';
import '../../models/stores_model/stores_model.dart';
import '../screens/dashboard/store/storeDetails.dart';
import '../screens/sign_in/initial_sign_in.dart';
import 'bottom_sheet.dart';
import 'custom_button.dart';
import 'package:get/get.dart';

import 'custom_snack.dart';


class storeCard extends StatefulWidget {
  const storeCard({Key? key, required this.stores}) : super(key: key);
  final StoreProduct stores;

  @override
  State<storeCard> createState() => _storeCardState();
}

class _storeCardState extends State<storeCard> {
  int quantity = 1;
  double amount = 0;
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

  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }
  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    customerId = userDetails.serviceProviders![0].serviceProviderId;
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
    amount = widget.stores.amount?.toDouble() ?? 0.0;
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
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
        width: MediaQuery.of(context).size.width * .42,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async{
                  await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return storeDetailsScreen(
                        id: widget.stores.productId, stores: widget.stores,
                    );
                  }));
                },
                child: Column(
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
                              image: widget.stores.photoUrlList == null || widget.stores.photoUrlList!.isEmpty || widget.stores.photoUrlList == [] ?
                              const NetworkImage(imagePlaceHolder) :
                              NetworkImage(widget.stores.photoUrlList![0].photoUrl.toString()),fit: BoxFit.cover,)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(widget.stores.vendorName.toString(), overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xff4F4F4F))),
                    const SizedBox(height: 5,),
                    Text(widget.stores.description.toString(), overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff4F4F4F))),
                    const SizedBox(height: 5,),
                    Text('₦ ${MoneyFormatter(
                        amount: widget.stores.amount?.toDouble() ?? 0.00
                    ).output.nonSymbol}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    RatingBar.builder(
                      glowColor:  const Color(0xffF2994A),
                      itemSize: 12,
                      initialRating: 5.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star, size: 12,
                        color: Color(0xffF2994A),
                      ),
                      onRatingUpdate: (rating) {
                        if (kDebugMode) {
                          print(rating);
                        }
                      },
                    ),
                    // const SizedBox(height: 20,),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: (){
                    esoLinkBottomSheet(
                        isDismissible: false,
                        children: [
                          StatefulBuilder(builder: (context, update){
                            return Column(
                              children: [
                                const SizedBox(height: 8,),
                                Align(alignment: Alignment.topCenter,
                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                const SizedBox(height: 18,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: const Align(alignment: Alignment.topRight,
                                    child: Icon(Icons.clear, color: Colors.black, size: 20,),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 150, width: MediaQuery.of(context).size.width/ 2.8,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: widget.stores.photoUrlList == null || widget.stores.photoUrlList!.isEmpty || widget.stores.photoUrlList == [] ?
                                            const NetworkImage(imagePlaceHolder) :
                                            NetworkImage(widget.stores.photoUrlList![0].photoUrl.toString()),fit: BoxFit.cover,)),
                                    ),
                                    const SizedBox(width: 15,),
                                    Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(widget.stores.description.toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff4F4F4F))),
                                            const SizedBox(height: 10,),
                                            Text('₦ ${MoneyFormatter(
                                                amount: widget.stores.amount?.toDouble() ?? 0.00
                                            ).output.nonSymbol}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    update((){
                                                      if(quantity == 0){
                                                        null;
                                                      }else{
                                                        quantity--;
                                                        widget.stores.amount = amount * quantity;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 26, width: 26,
                                                    decoration: const BoxDecoration(color: Color(0xffE6E6E6), shape: BoxShape.circle),
                                                    child: Center(child: Icon(Icons.remove, color: white,size: 15)),
                                                  ),
                                                ),
                                                const SizedBox(width: 13,),
                                                Text("$quantity", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),
                                                const SizedBox(width: 13,),
                                                GestureDetector(
                                                  onTap: (){
                                                    update((){
                                                      quantity++;
                                                      widget.stores.amount = amount * quantity;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 26, width: 26,
                                                    decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle,),
                                                    child: Center(child: Icon(Icons.add, color: white, size: 15),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                            CustomButton(
                                              onTap: () async {
                                                if(loginStatus == true ){
                                                  if(customerId == null){
                                                    null;
                                                  }else{
                                                    Navigator.of(context).pop();
                                                    quantity == 0 ?
                                                    showErrorSnackBar(context,
                                                        title: "Oops!",
                                                        content: "Quantity cannot be 0") :
                                                    controller.addItemToCart(productId: widget.stores.productId!, vendorId: widget.stores.vendorId!,
                                                        quantity: quantity, amount: widget.stores.amount!.toInt(), customerId: customerId!, context: context);
                                                  }
                                                }else{
                                                  showAlertDialog(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "store",)));
                                                      }
                                                  );
                                                }
                                              },
                                              text: "Add",
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                        ], context: context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text("Add to Cart", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: Colors.white),),
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
