import 'package:esolink/logic/api_services/services.dart';
import 'package:esolink/models/services_category/all_categories_response_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/all_category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../logic/services_category/service_bloc.dart';
import '../../../../service_locator.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
  final List<AllCategory> _categories = <AllCategory>[];

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
            title: Text("Categories",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
      body: RefreshIndicator(
        onRefresh: ()async{
          ApiServices().getAllCategories().then((data) => setState(() {
            _categories.addAll(data);
            print(_categories.length);
          }));
        },
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
              FutureBuilder<List<AllCategory>>(
                  future: ApiServices().getAllCategories(),
                  builder: (context, snapshot) {
                    while (!snapshot.hasData) {
                      return Column(
                        children: const [
                          SizedBox(height: 320,),
                          Center(
                              child:
                              CupertinoActivityIndicator()),
                        ],
                      );
                    }
                    return GridView.count(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        ...snapshot.data!
                            .map((e) => AllCategoryCard(
                          allCategory: e,
                        ))
                            .toList()
                      ],
                    );
                  })
            ],
          ),
        ),
      )
    );
  }
}
