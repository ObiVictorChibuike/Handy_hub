import 'dart:developer';

import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/login/registration_controller.dart';
import 'package:esolink/logic/store/store_controller.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/account/all_requested_services.dart';
import 'package:esolink/models/stores_model/store_response.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/store/cart_page.dart';
import 'package:esolink/views/screens/sign_in/initial_sign_in.dart';
import 'package:esolink/views/widgets/add_to_cart_card.dart';
import 'package:esolink/views/widgets/bottom_sheet.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:esolink/views/widgets/filter_dropdown.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      _firstLoad();
      _scrollController = ScrollController()..addListener(_loadMore);
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

  int page = 1;
  final int _limit = 20;
  bool hasNextPage = true;
  bool isLoadingMoreData = false;
  bool _isFirstLoadRunning = false;
  List<StoreProduct>? storeProductList = <StoreProduct>[].obs;

  final StoreController sc = Get.put(StoreController());
  final RegistrationController rc = Get.put(RegistrationController());
  late ScrollController _scrollController;

  Future<void> _loadMore() async {
    if(hasNextPage == true && _isFirstLoadRunning == false && isLoadingMoreData == false
        && _scrollController.position.extentAfter < 300){
      setState(() {
        isLoadingMoreData = true;
      });
      page += 1;
      try{
        var response = await NetworkProvider().call(path: "/Stores/all/products/by/category/pagination?PageNumber=$page&PageSize=$_limit&PageId=${widget.id}", method: RequestMethod.get,);
        final payLoad = StoreResponse.fromJson(response!.data).response?.data;
        if(payLoad!.isNotEmpty){
          setState(() {
            storeProductList?.addAll(payLoad);
            sc.storeProductList?.addAll(payLoad);
          });
        }else{
          setState(() {
            hasNextPage = false;
          });
        }
      }catch(err){
        throw err.toString();
      }
      setState(() {
        isLoadingMoreData = false;
      });
    }
  }

  void _firstLoad()async{
    setState(() {
      _isFirstLoadRunning = true;
    });
    try{
      var response = await NetworkProvider().call(path: "/Stores/all/products/by/category/pagination?PageNumber=$page&PageSize=$_limit&PageId=${widget.id}", method: RequestMethod.get,);
      setState(() {
        storeProductList = StoreResponse.fromJson(response!.data).response?.data;
        sc.storeProductList = StoreResponse.fromJson(response.data).response?.data;
        log('This is the length ${storeProductList?.length}');
      });
    }catch(err){
      throw err.toString();
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  int? stateId;

  var price =[
    "Under #2000",
    "#2000 - #5000",
    "#5000 - #10000",
    "#10000 - #15000",
    "#15000 - #20000",
    "#20000 - #25000",
  ];
  var rating = [1, 2, 3, 4, 5];
  int? ratingFilterValueIndex;
  int? priceFilterValueIndex;
  String? selectedRating;
  int? selectedPrice;
  int? v1,v2,v3,v4,v5,v6;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
        builder: (controller){
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
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
            title: Text(widget.title!,textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 12),
              child: GestureDetector(
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
            ),
          ],
        ),
        body: Column(
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        storeProductList = sc.storeProductList;
                        stateId = null;
                        esoLinkBottomSheet(children: [
                          StatefulBuilder(builder: (context, update){
                            return Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8,),
                                Align(alignment: Alignment.topCenter,
                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                const SizedBox(height: 18,),
                                GestureDetector(
                                  onTap: (){
                                    stateId = null;
                                    Navigator.of(context).pop();
                                  },
                                  child: const Align(alignment: Alignment.topLeft,
                                    child: Icon(Icons.clear, color: Colors.black, size: 30,),
                                  ),
                                ),
                                Align(alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      storeProductList = sc.storeProductList;
                                      if(stateId != null) {
                                        setState(() {
                                          final locationList = storeProductList?.where((element) => element.stateId == stateId).toList();
                                          storeProductList = locationList;
                                        });
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      height: 35, width: MediaQuery.of(context).size.width/4,
                                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                                      child: Center(child: Text('Apply Filter', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 13),),),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Text("Location", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 10,),
                                FilterDropDownTextField(
                                  onChanged: (value) {
                                    final index = rc.allStateResponse?.state?.indexWhere((element) => element.stateName == value.toString());
                                    stateId = rc.allStateResponse!.state![index!].stateId;
                                    log(stateId.toString());
                                  },
                                  items: rc.allStateResponse?.state?.map((item) => DropdownMenuItem<String>(
                                    value: item.stateName ?? "",
                                    child: Text("${item.stateName}",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                                  )).toList(),
                                  title: "Select Location",
                                ),
                              ],
                            );
                          }),
                        ], context: context, isDismissible: false, height:  MediaQuery.of(context).size.height/2.8);
                      },
                      child: Container(
                        color: Colors.white,
                        child: const Row(
                          children: [
                            Icon(Icons.filter_alt, color: Color(0XFF187226),),
                            Text('Filters', style: TextStyle(color: Color(0XFF187226)),),
                          ],
                        ),
                      ),
                    ),
                    const Text('|',style: TextStyle(color: Color(0XFF187226)),),
                    GestureDetector(
                      onTap: (){
                        storeProductList = sc.storeProductList;
                        selectedPrice = null;
                        priceFilterValueIndex = null;
                        esoLinkBottomSheet(children: [
                          StatefulBuilder(builder: (context, update){
                            return Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8,),
                                Align(alignment: Alignment.topCenter,
                                    child: Container(height: 5, width: 50, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),)),
                                const SizedBox(height: 18,),
                                GestureDetector(
                                  onTap: (){
                                    storeProductList = sc.storeProductList;
                                    selectedPrice = null;
                                    priceFilterValueIndex = null;
                                    Navigator.of(context).pop();
                                  },
                                  child: const Align(alignment: Alignment.topLeft,
                                    child: Icon(Icons.clear, color: Colors.black, size: 30,),
                                  ),
                                ),
                                Align(alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      if(selectedPrice != null){
                                        setState(() {
                                          final priceList = storeProductList?.where((element) =>
                                          priceFilterValueIndex == 0 && element.amount != null ? element.amount!.toInt() >= 10 && element.amount!.toInt() <= v1! :
                                          priceFilterValueIndex == 1 && element.amount != null ? element.amount!.toInt() >= 2000 && element.amount!.toInt() <= v2! :
                                          priceFilterValueIndex == 2 && element.amount != null ? element.amount!.toInt() >= 5000 && element.amount!.toInt() <= v3! :
                                          priceFilterValueIndex == 3 && element.amount != null ? element.amount!.toInt() >= 10000 && element.amount!.toInt() <= v4! :
                                          priceFilterValueIndex == 4 && element.amount != null ? element.amount!.toInt() >= 15000 && element.amount!.toInt() <= v5! :
                                          priceFilterValueIndex == 5 && element.amount != null ? element.amount!.toInt() >= 20000 && element.amount!.toInt() <= v6! :
                                          element.amount?.toInt() != null
                                          ).toList();
                                          storeProductList = priceList;
                                        });
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      height: 35, width: MediaQuery.of(context).size.width/4,
                                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                                      child: Center(child: Text('Apply Filter', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 13),),),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 9,),
                                const Divider(),
                                const SizedBox(height: 9,),
                                Text("Price", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(price.length, (index){
                                      return GestureDetector(
                                        onTap: (){
                                          update(() {
                                            priceFilterValueIndex = index;
                                          });
                                          if(index == 0){
                                            selectedPrice = 2000;
                                            v1 = 2000;
                                          }else if(index == 1){
                                            selectedPrice = 5000;
                                            v2 = 5000;
                                          }else if(index == 2){
                                            selectedPrice = 10000;
                                            v3 = 10000;
                                          }else if(index == 3){
                                            selectedPrice = 15000;
                                            v4 = 15000;
                                          }else if(index == 4){
                                            selectedPrice = 20000;
                                            v5 = 20000;
                                          }else if(index == 5){
                                            selectedPrice = 25000;
                                            v6 = 25000;
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 18, width: 18,
                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Container(
                                                    height: 12, width: 12,
                                                    decoration: BoxDecoration(color: priceFilterValueIndex == index ? primaryColor
                                                        : Colors.white, shape: BoxShape.circle),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8,),
                                              Text(price[index]),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                                // const Divider(),
                                // Text("Rating", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                // const SizedBox(height: 10,),
                                // Column(crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     ...List.generate(rating.length, (index){
                                //       return GestureDetector(
                                //         onTap: (){
                                //           update((){
                                //             ratingFilterValueIndex = index;
                                //           });
                                //           if(index == 0){
                                //             selectedRating = 1.toString();
                                //           }else if(index == 1){
                                //             selectedRating = 2.toString();
                                //           }else if(index == 2){
                                //             selectedRating = 3.toString();
                                //           }else if(index == 3){
                                //             selectedRating = 4.toString();
                                //           }else if(index == 4){
                                //             selectedRating = 5.toString();
                                //           }
                                //         },
                                //         child: Container(color: Colors.white,
                                //           padding: const EdgeInsets.symmetric(vertical: 5.0),
                                //           child: Row(
                                //             children: [
                                //               Container(
                                //                 height: 18, width: 18,
                                //                 decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.all(3.0),
                                //                   child: Container(
                                //                     height: 12, width: 12,
                                //                     decoration: BoxDecoration(color: ratingFilterValueIndex == index ? primaryColor
                                //                         : Colors.white, shape: BoxShape.circle),
                                //                   ),
                                //                 ),
                                //               ),
                                //               const SizedBox(width: 8,),
                                //               RatingBar.builder(
                                //                 ignoreGestures: true,
                                //                 glowColor:  const Color(0xffF2994A),
                                //                 itemSize: 15,
                                //                 initialRating: rating[index].toDouble(),
                                //                 minRating: 1,
                                //                 direction: Axis.horizontal,
                                //                 allowHalfRating: true,
                                //                 itemCount: 5,
                                //                 itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                //                 itemBuilder: (context, _) => const Icon(
                                //                   Icons.star, size: 12,
                                //                   color: Color(0xffF2994A),
                                //                 ),
                                //                 onRatingUpdate: (rating) {
                                //                 },
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     })
                                //   ],
                                // ),
                              ],
                            );
                          }),
                        ], context: context, isDismissible: false, height:  MediaQuery.of(context).size.height/2.2);
                      },
                      child: Container(
                        color: Colors.white,
                        child: const Row(
                          children: [
                            Icon(Icons.filter_list_outlined, color: Color(0XFF187226),),
                            Text('Sort', style: TextStyle(color: Color(0XFF187226)),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const storeCard()
            const SizedBox(height: 30,),
            _isFirstLoadRunning ?
            const Center(
              child: CupertinoActivityIndicator(),
            ) : storeProductList!.isEmpty || storeProductList == [] ?
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(height: MediaQuery.of(context).size.height /3,),
              const Center(child: Text('This products are not available in this location', style: TextStyle(color: Colors.red),)),
              SizedBox(height: MediaQuery.of(context).size.height /3,),
            ],
          ) :
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
                child:  GridView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 2, crossAxisCount: 2,mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: storeProductList!.length,
                  itemBuilder: (_,index){
                    return storeCard(stores: storeProductList![index]);
                  },
                ),
              ),
            ),
            if(isLoadingMoreData == true)
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 30),
                child: CupertinoActivityIndicator(),
              ),
            if(hasNextPage == false)
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                color: Colors.white, child: const Center(
                child: Text("You have fetched all the content"),
              ),
              )
          ],
        ),
      );
    });
  }
}
