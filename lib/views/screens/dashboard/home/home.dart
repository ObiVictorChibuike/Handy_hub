import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esolink/local_notification_services.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/home/controller.dart';
import 'package:esolink/logic/login/login_controller.dart';
import 'package:esolink/logic/login/registration_controller.dart';
import 'package:esolink/logic/payment/fund_wallet.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/categories/categories_screen.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/dashboard/requests/fetched_request.dart';
import 'package:esolink/views/widgets/bottom_sheet.dart';
import 'package:esolink/views/widgets/catogories_card.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool show = false;bool see = false;
  final rc = Get.put(RegistrationController());
  List<AllCategory> result = <AllCategory>[];
  pushNotificationOnInitConfiguration() {
    // LocalNotificationService.initialize();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Get.to(() => const Dashboard());
      }
    });
    //Is called when the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {}
      LocalNotificationService.displayNotification(message);
    });
    //Only works When the app is in background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
      Get.to(() => const Dashboard());
    });
  }

  @override
  void initState() {
    pushNotificationOnInitConfiguration();
    getAuthUser();
    super.initState();
  }

  void input(String value) {
    value.isEmpty
        ? setState(() {
            show = false;
          })
        : setState(() {
            show = true;
            result = rc.allCategory.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
          });
  }
  HomeController ctrl = Get.put(HomeController());
  RegistrationController registrationController = Get.put(RegistrationController());
  LoginController lc = Get.put(LoginController());
  AuthUserResponse? authUserResponse;
  String? name;
  String? email;
  String? phoneNumber;

  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    if(isLoggedIn == true){
      final authEmail = await LocalCachedData.instance.getCustomerEmail();
      lc.getAuthUser(email: authEmail).then((value) async {
        await LocalCachedData.instance.fetchUserDetails().then((value){
          setState(() {
            authUserResponse = value;
            phoneNumber = value.serviceProviders?[0].phoneNumber;
            email = value.serviceProviders?[0].email;
            name = value.serviceProviders?[0].firstName;
          });
        });
      });
    }else{
      null;
    }
  }

  final buttonTitle = [
    "Fund Wallet",
  ];

  final walletPaymentAmountController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
          MoneyFormatter formatWalletBalance = MoneyFormatter(
              amount: authUserResponse?.serviceProviders?[0].wallet?.toDouble() ?? 0.00
          );
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: ()async{
                await controller.getCategories();
                },
              child: controller.onCategoryHasData == false ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 1),
                      baseColor: Colors.grey.shade400,
                      highlightColor: const Color(0xff6F6F6F).withOpacity(0.5),
                      child: Container(height: 35, width: double.maxFinite, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey, ),),
                    ),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 1),
                      baseColor: Colors.grey.shade400,
                      highlightColor: const Color(0xff6F6F6F).withOpacity(0.5),
                      child: Container(height: 170, padding: const EdgeInsets.symmetric(vertical: 30),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(8), height: 170, width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                          ),
                          separatorBuilder: (_, __) => const SizedBox(width: 10,),
                          itemCount: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 1),
                      baseColor: Colors.grey.shade400,
                      highlightColor: const Color(0xff6F6F6F)
                          .withOpacity(0.5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 14,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 14,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    const Divider(),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 1),
                      baseColor: Colors.grey.shade400,
                      highlightColor: const Color(0xff6F6F6F)
                          .withOpacity(0.5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 14,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 14,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Shimmer.fromColors(
                      period: const Duration(seconds: 1),
                      baseColor: Colors.grey.shade400,
                      highlightColor: const Color(0xff6F6F6F)
                          .withOpacity(0.5),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          Container(
                            height: 45, width: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ) :
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CupertinoSearchTextField(
                          onChanged: (value) => input(value),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        show ? SizedBox(
                            height: MediaQuery.of(context).size.height * .74,
                            child: ListView.separated(
                              itemCount: result.isEmpty ? 0 : result.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return FetchedRequestScreen(
                                            id: result[index]
                                                .categoryId
                                                .toString(),
                                            title: result[index].name);
                                      }));
                                },
                                child: SingleChildScrollView(
                                  child: ListTile(
                                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                                    title: Text(result[index]
                                        .name
                                        .toString()),
                                  ),
                                ),
                              ), separatorBuilder: (BuildContext context, int index) { return const Divider(); },))
                            : SizedBox(
                          height: MediaQuery.of(context).size.height * .82,
                          child: Column(children: [
                            SizedBox(
                              height: 140,
                              child: ListView(
                                children: [
                                  CarouselSlider(
                                    items: registrationController.dashboardPhotoResponse?.map((e){
                                      return  ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: e.photoUrl ?? imagePlaceHolder,
                                            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 2.6),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                PopupMenuButton(
                                  child:  const Row(
                                    children: [
                                      EsolinkIcons(
                                        icons: "menu",),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      EsolinkIcons(
                                        icons: "card",
                                      ),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return List.generate(buttonTitle.length, (index) {
                                      return PopupMenuItem(
                                        child: Text(buttonTitle[index], style: TextStyle(color: primaryColor),),
                                        onTap: (){
                                          if(index == 0){
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                                          const Align(alignment: Alignment.centerLeft,
                                                              child: Text("Enter Amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                                          const SizedBox(height: 20,),
                                                          PlainTextField(
                                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                            keyboardType: TextInputType.number,
                                                            controller: walletPaymentAmountController,
                                                            label: "Enter Amount",
                                                            hint: "Amount",
                                                          ),
                                                          const SizedBox(height: 15,),
                                                          GestureDetector(
                                                            onTap: (){
                                                              if(walletPaymentAmountController.text.isEmpty){
                                                                null;
                                                              }else{
                                                                FundAccountWallet(encryptionKey, publicKey, walletPaymentAmountController.text,
                                                                    email ?? "", phoneNumber ?? "", name ?? "", context).chargeCard();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: double.maxFinite,
                                                              height: 45, decoration: BoxDecoration(
                                                              color: primaryColor, borderRadius: BorderRadius.circular(10),
                                                            ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Continue",
                                                                  style: subHeaderText.copyWith(fontSize: 13, color: white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ], context: context);
                                            });
                                          }else{
                                            null;
                                          }
                                        },
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                see
                                    ? Text(
                                  "N ${formatWalletBalance.output.nonSymbol}",
                                  style: subHeaderText.copyWith(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                )
                                    : Text(
                                  "*******",
                                  style: subHeaderText.copyWith(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: see
                                      ? Icon(Icons.visibility,
                                      size: 15, color: primaryColor)
                                      : Icon(Icons.visibility_off,
                                      size: 15, color: primaryColor),
                                  onPressed: () {
                                    setState(() {
                                      see = !see;
                                    });
                                  },
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .5,
                              child: ListView(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Popular Services",
                                        style: subHeaderText.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return CategoriesScreen();
                                                  }));
                                        },
                                        child: Text("View All",
                                            style: subHeaderText.copyWith(
                                              color: primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  GridView.count(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    children: [
                                      ...controller.categories.map((e) => CategoriesCard(
                                        categoriesModel: e,
                                      )).toList()
                                    ],
                                  )
                                  // controller.onCategoryHasData == false ?
                                  // const Center(
                                  //     child: CupertinoActivityIndicator())
                                  // :
                                  // FutureBuilder<List<CategoriesModel>>(
                                  //     future: ApiServices().getCategories(),
                                  //     builder: (context, snapshot) {
                                  //       while (!snapshot.hasData) {
                                  //         return const Center(
                                  //             child: CupertinoActivityIndicator());
                                  //       }
                                  //       return GridView.count(
                                  //         physics: const BouncingScrollPhysics(),
                                  //         shrinkWrap: true,
                                  //         crossAxisCount: 3,
                                  //         mainAxisSpacing: 10,
                                  //         crossAxisSpacing: 10,
                                  //         children: [
                                  //           ...snapshot.data!
                                  //               .map((e) => CategoriesCard(
                                  //             categoriesModel: e,
                                  //           ))
                                  //               .toList()
                                  //         ],
                                  //       );
                                  //     })
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }
}
