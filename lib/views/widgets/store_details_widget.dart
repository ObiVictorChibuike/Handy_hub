import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/models/stores_model/product_details.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/image_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import 'bottom_sheet.dart';
import 'custom_button.dart';
import 'custom_scroll_physics.dart';
import 'custom_snack.dart';

class StoreDetailsWidget extends StatefulWidget {
  final Stores stores;
  const StoreDetailsWidget({Key? key, required this.stores}) : super(key: key);

  @override
  State<StoreDetailsWidget> createState() => _StoreDetailsWidgetState();
}

class _StoreDetailsWidgetState extends State<StoreDetailsWidget> {
  final ctrl = PageController();
  int current = 0;
  int quantity = 0;
  double amount = 0;
  bool? loginStatus;
  int? customerId;

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
  @override
  Widget build(BuildContext context) {
    amount = widget.stores.amount ?? 0.0;
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          widget.stores.photoUrlList!.isEmpty ||
              widget.stores.photoUrlList == [] ||
              widget.stores.photoUrlList == null ?
          SizedBox(
            height: MediaQuery.of(context).size.height/2.7, width: MediaQuery.of(context).size.width,
            child: PageView.builder(
                physics: const CustomPageViewScrollPhysics(),
                itemCount: 6,
                pageSnapping: true,
                controller: ctrl,
                onPageChanged: (page) {
                  setState(() {
                    current = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(imagePlaceHolder),
                  );
                }),
          ) :
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.7, width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: PageView.builder(
                    physics: const CustomPageViewScrollPhysics(),
                    itemCount: widget.stores.photoUrlList!.length,
                    pageSnapping: true,
                    controller: ctrl,
                    onPageChanged: (page) {
                      setState(() {
                        current = page;
                      });
                    },
                    itemBuilder: (context, pagePosition) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(widget.stores.photoUrlList![pagePosition].photoUrl!, fit: BoxFit.cover,),
                      );
                    }),
              ),
              Positioned(
                right: 30,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                  child: Text("${current + 1} / ${widget.stores.photoUrlList!.length}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.stores.photoUrlList!.map((x) {
              final index = widget.stores.photoUrlList!.indexOf(x);
              return Container(
                width: 5.0,
                height: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: current == index
                      ? primaryColor
                      : Colors.grey.shade400,
                ),
              );
            }).toList(),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.stores.name.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff333333))),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Text("Vendor:",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff4F4F4F))),
                    const SizedBox(width: 5,),
                    Text(widget.stores.vendorName ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff333333))),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Text("Category:",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff4F4F4F))),
                    const SizedBox(width: 5,),
                    Text(widget.stores.categoryName ?? "",
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff333333))),
                  ],
                ),
                const SizedBox(height: 5,),
                Text("N ${widget.stores.amount?.toInt().toString() ?? 0}",
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff333333))),
                const SizedBox(height: 5,),
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
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Product Details",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xff333333))),
                const SizedBox(height: 5,),
                ReadMoreText(
                  widget.stores.description ?? "",
                  trimLines: 3,
                  style: subHeaderText.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  colorClickableText: primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomButton(
              onTap: ()async{
                esoLinkBottomSheet(children: [
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
                                    Text('₦ ${widget.stores.amount.toString()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    const SizedBox(height: 15,),
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
                                    const SizedBox(height: 15,),
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
                                        } else{
                                          showAlertDialog(onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const InitialSignIn(route: "store",)));
                                          });
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
              text: "Add to Cart",
            ),
          ),
          const SizedBox(height: 30,)
        ],
      );
    });
  }
}
