import 'dart:developer';

import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/payment/payment_page.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_radio.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  bool cardPayment = false;
  bool directPayment = false;
  String? name;
  String? email;
  String? phoneNumber;





  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    name = userDetails.serviceProviders![0].fullName;
    email = userDetails.serviceProviders![0].email;
    phoneNumber = userDetails.serviceProviders![0].phoneNumber;
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
      return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
            centerTitle: true,
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
            title: Text("Cart",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        body: controller.isLoading == true ? const Center(
            child: CupertinoActivityIndicator()) :
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            controller.totalCartItemResponse == null || controller.totalCartItemResponse!.cart!.cartList!.isEmpty || controller.totalCartItemResponse?.cart?.cartList == null ||
                controller.totalCartItemResponse?.cart?.cartList == [] ?
                Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                      Icon(Icons.remove_shopping_cart_rounded, color: primaryColor, size: 38,),
                      const SizedBox(height: 20,),
                      const Text('No item in cart', style: TextStyle(color: Colors.red),),
                      SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                    ],
                  ),
                ) :
                Column(
                  children: [
                    ...controller.totalCartItemResponse!.cart!.cartList!.where((element) => element.quantity != 0).map((e){
                      MoneyFormatter amount = MoneyFormatter(
                          amount: e.amount?.toDouble() ?? 0.00
                      );
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],),
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                      height: 100, width: 100, decoration: BoxDecoration(borderRadius:  BorderRadius.circular(16)),
                                      child: Image.network(e.photoUrlList![0].photoUrl ?? imagePlaceHolder, fit: BoxFit.cover,height: 100, width: 100,)),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.productName ?? "", style: subHeaderText.copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                      Text("N ${amount.output.nonSymbol}", style: subHeaderText.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.favorite, color: Colors.grey,),
                                    const SizedBox(width: 20,),
                                    GestureDetector(
                                      onTap: (){
                                        controller.removeItemFromCart(cartId: e.cartId!, context: context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: primaryColor,),
                                          Text("Remove", style: subHeaderText.copyWith(
                                              color: primaryColor, fontSize: 12,
                                              fontWeight: FontWeight.w400)
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        controller.decreaseQuantity(cartId: e.cartId!,
                                            productId: e.productId!,
                                            quantity: e.quantity! - 1, context: context);
                                      },
                                      child: Container(
                                        height: 26, width: 26,
                                        decoration: const BoxDecoration(color: Color(0xffE6E6E6), shape: BoxShape.circle),
                                        child: Center(child: Icon(Icons.remove, color: white,size: 15)),
                                      ),
                                    ),
                                    const SizedBox(width: 13,),
                                    Text("${e.quantity ?? 0}", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
                                    const SizedBox(width: 13,),
                                    GestureDetector(
                                      onTap: (){
                                        controller.increaseQuantity(cartId: e.cartId!,
                                            productId: e.productId!,
                                            quantity: e.quantity! + 1, context: context);
                                      },
                                      child: Container(
                                        height: 26, width: 26,
                                        decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle,),
                                        child: Center(child: Icon(Icons.add, color: white, size: 15),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 25,),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          directPayment = false;
                          cardPayment = true;
                        });
                      },
                      child: Card(elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Card",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14) ),
                              CustomRadio(
                                value: cardPayment,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          directPayment = true;
                          cardPayment = false;
                        });
                      },
                      child: Card(elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Wallet",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14) ),
                              CustomRadio(
                                value: directPayment,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(color: Colors.white,),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sub Total",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),),
                                Text(MoneyFormatter(
                                    amount: controller.totalCartItemResponse?.cart?.cartTotalSum?.toDouble() ?? 0.00
                                ).output.nonSymbol,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tax", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),),
                                Text("750", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Delivery Fee", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),),
                                Text("500", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                              ],
                            ),
                            const Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),),
                                Text(MoneyFormatter(amount: controller.totalCartItemResponse?.cart?.cartTotalSum?.toDouble() ?? 0.00).output.nonSymbol,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomButton(
                onTap: ()async{
                  if(cardPayment == false && directPayment == false){
                    showErrorSnackBar(context,
                        title: "Oops!",
                        content: "Please select payment method");
                  }else if(cardPayment == true){
                    controller.totalCartItemResponse!.cart!.cartList!.where((element) => element.quantity != 0).isEmpty ? null :
                    PayWithCardPayment(encryptionKey, publicKey, controller.totalCartItemResponse!.cart!.cartTotalSum.toString(),
                        email ?? "", phoneNumber ?? "", name ?? "", context).chargeCard();
                  }else if(directPayment == true){
                    controller.totalCartItemResponse!.cart!.cartList!.where((element) => element.quantity != 0).isEmpty ? null :
                    controller.directPaymentCheckOut(amount: controller.totalCartItemResponse!.cart!.cartTotalSum!.toInt(), context: context);
                  }
                },
                text: "Complete Order",
              ),
            ),
            const SizedBox(height: 60,),
          ],
        ),
      );
    });
  }

  final ctrl = Get.put(StoreController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      ctrl.getTotalCartItemInit(context: context);
      getAuthUser();
    });
    super.initState();
  }
}
