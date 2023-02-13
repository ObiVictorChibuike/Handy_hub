import 'package:carousel_slider/carousel_slider.dart';
import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/services_category/services_request.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/categories/categories_screen.dart';
import 'package:esolink/views/widgets/catogories_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../requests/fetched_request.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();

  bool show = false;
  final List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> display = [];
  List<CategoriesModel> result = <CategoriesModel>[];

  @override
  void initState() {
    // TODO: implement initState
    ApiServices().getCategories().then((data) => setState(() {
          _categories.addAll(data);
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
            result = _categories
                .where((element) =>
                    element.name!.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xE5E5E5),
        body: SafeArea(
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
                        child: Expanded(
                          child: ListView.builder(
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
                                        titleColor: Colors.white,
                                        title: Text(result[index]
                                            .description
                                            .toString()),
                                      ),
                                    ),
                                  )),
                        ))
                    : Container(
                        height: MediaQuery.of(context).size.height * .74,
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
                              show
                                  ? Text(
                                      "N120,000.00",
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
                                icon: show
                                    ? Icon(Icons.visibility,
                                        size: 15, color: primaryColor)
                                    : Icon(Icons.visibility_off,
                                        size: 15, color: primaryColor),
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(),
                          ),
                          Expanded(
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
                                StreamBuilder<List<CategoriesModel>>(
                                    stream: categoriesBloc.allCategories,
                                    builder: (context, snapshot) {
                                      while (!snapshot.hasData) {
                                        return const Center(
                                            child:
                                                CupertinoActivityIndicator());
                                      }
                                      return GridView.count(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 10.2,
                                        children: [
                                          ...snapshot.data!
                                              .take(9)
                                              .map((e) => CategoriesCard(
                                                    categoriesModel: e,
                                                  ))
                                              .toList()
                                        ],
                                      );
                                    })
                              ],
                            ),
                          ),
                        ]),
                      ),
              ],
            ),
          ),
        ));
  }
}
