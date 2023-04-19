import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/home/controller.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/services_category/services_request.dart';
import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/categories/categories_screen.dart';
import 'package:esolink/views/widgets/catogories_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../requests/fetched_request.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();

  bool show = false;
  bool see = false;
  final List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> display = [];
  List<CategoriesModel> result = <CategoriesModel>[];

  @override
  void initState() {
    getAuthUser();
    ApiServices().getCategories().then((data) => setState(() {
          _categories.addAll(data);
          print(_categories.length);
        }));
    print(_categories.length);
    super.initState();
  }

  void input(String value) {
    value.isEmpty
        ? setState(() {
            show = false;
          })
        : setState(() {
            show = true;
            result = _categories.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
          });
  }
  HomeController ctrl = Get.put(HomeController());
  AuthUserResponse? authUserResponse;

  Future<void> getAuthUser() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.fetchUserDetails().then((value){
      authUserResponse = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xffE5E5E5),
          body: SafeArea(
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
                    show
                        ? Container(
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
                        : Container(
                      height: MediaQuery.of(context).size.height * .82,
                      child: Column(children: [
                        Container(
                          height: 140,
                          child: ListView(
                            children: [
                              CarouselSlider(
                                items: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/display_1.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/display_2.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/display_3.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
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
                            const EsolinkIcons(
                              icons: "menu",
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const EsolinkIcons(
                              icons: "card",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            see
                                ? Text(
                              "N ${authUserResponse?.serviceProviders?[0].wallet?.toInt() ?? 0.00}",
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
                        Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: ListView(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
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
                              controller.onCategoryHasData == false ?
                              const Center(
                                  child: CupertinoActivityIndicator())
                              : GridView.count(
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
          ));
    });
  }
}
