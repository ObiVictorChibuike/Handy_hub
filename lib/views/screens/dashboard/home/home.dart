import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/categories/categories_screen.dart';
import 'package:esolink/views/widgets/catogories_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0x00f9f9f9),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70)),
                  elevation: 4,
                  child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 9),
                        filled: true,
                        fillColor: white,
                        hintText: "Search for available services",
                        hintStyle: subHeaderText.copyWith(
                            color: const Color(0xffBDBDBD),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        suffixIcon: const Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const EsolinkIcons(
                  image: "display_1",
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
                    Text(
                      "N120,000",
                      style: subHeaderText.copyWith(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.visibility,
                      size: 15,
                      color: primaryColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: subHeaderText.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
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
                                  child: CupertinoActivityIndicator());
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
              ],
            ),
          ),
        ));
  }
}
