import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../logic/services_category/service_bloc.dart';
import '../../../../models/services_category/categories.dart';
import '../../../../service_locator.dart';
import '../../../widgets/catogories_card.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
  final List<CategoriesModel> _categories = <CategoriesModel>[];
  List<CategoriesModel> display = [];
  List<CategoriesModel> result = <CategoriesModel>[];

  @override
  void initState() {
    // TODO: implement initState
    ApiServices().getAllCategories().then((data) => setState(() {
      _categories.addAll(data);
      print(_categories.length);
    }));
    print(_categories.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        title: "Categories",
        action: const Icon(
          Icons.search_rounded,
          color: Color(0xff828282),
          size: 14,
        ),
        body: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 22, bottom: 22),
            child: ListView(
              children: [
                // StreamBuilder<List<CategoriesModel>>(
                //     stream: categoriesBloc.allCategories,
                //     builder: (context, snapshot) {
                //       while (!snapshot.hasData) {
                //         return const Center(
                //             child: CupertinoActivityIndicator());
                //       }
                //       return GridView.count(
                //         physics: const BouncingScrollPhysics(),
                //         shrinkWrap: true,
                //         crossAxisCount: 3,
                //         mainAxisSpacing: 8,
                //         crossAxisSpacing: 4,
                //         children: [
                //           ...snapshot.data!
                //               .map((e) => CategoriesCard(
                //                     categoriesModel: e,
                //                   ))
                //               .toList()
                //         ],
                //       );
                //     }),
                FutureBuilder<List<CategoriesModel>>(
                    future: ApiServices().getAllCategories(),
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
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          ...snapshot.data!
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
        ),
      ),
    );
  }
}
