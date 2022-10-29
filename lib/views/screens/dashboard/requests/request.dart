import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/requests/fetched_request.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';

import '../../../../models/services_category/categories.dart';
import '../../../../service_locator.dart';
import '../../../widgets/custom_fields.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();

  final RequestBLoc requestBLoc = locator.get<RequestBLoc>();

  @override
  void dispose() {
    requestBLoc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWithBackButton(
        automaticallyImplyLeading: false,
        title: "Requests",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StreamBuilder<List<CategoriesModel>>(
                    initialData: [
                      CategoriesModel.fromJson(
                        {
                          "categoryId": 14,
                          "name": " Architect",
                          "icon":
                              "https://res.cloudinary.com/esolink/image/upload/v1641928046/ikbniod9u9l4narj50aj.png",
                          "publicId": null,
                          "description": " Architect",
                          "supervisorName": "Fortune Johnbull",
                          "supervisorEmail": "goodyrhome@gmail.com ",
                          "supervisorNumber": "2349056309508",
                          "group": "B",
                          "active": null,
                          "deleted": null,
                          "createdBy": null,
                          "createdOn": null,
                          "updatedBy": null,
                          "updatedOn": null
                        },
                      )
                    ],
                    stream: categoriesBloc.allCategories,
                    builder: (context, snapshot) {
                      if (snapshot.data != null && snapshot.data!.isEmpty) {
                        return const SizedBox();
                      }
                      return CategoryField(
                        stream: requestBLoc.requestID,
                        onchanged: requestBLoc.addRequestID,
                        value: snapshot.data.toString(),
                        items:
                            snapshot.data!.map<dynamic>((CategoriesModel? e) {
                          return e;
                        }).toList(),
                        hint: "Search for available services",
                        label: "What service do you need?",
                      );
                    }),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: StreamBuilder<String>(
                      stream: requestBLoc.requestID,
                      builder: (context, snapshot) {
                        return CustomButton(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FetchedRequestScreen(
                                catID: snapshot.data,
                                
                               
                                // title: ,
                              );
                            }));
                          },
                          enabled: snapshot.hasData ? true : false,
                          text: "Find Service",
                        );
                      }),
                ),
                const SizedBox(
                  height: 120,
                ),
                const EsolinkIcons(
                  icons: "search_req",
                )
              ]),
        ),
      ),
    );
  }
}
