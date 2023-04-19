import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_controller.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/requests/fetched_request.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service_locator.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();

  final RequestBLoc requestBLoc = locator.get<RequestBLoc>();
  int? categoryId;
  String? title;

  @override
  void dispose() {
    requestBLoc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      init: RequestController(),
        builder: (controller){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Requests"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22,),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                Align(alignment: Alignment.topLeft,
                  child: Text("What service do you need?",style: subHeaderText.copyWith(
                    fontSize: 15,
                  )),
                ),
                const SizedBox(height: 25,),
                DropDownTextField(
                  onChanged: (value) {
                    controller.selectedCategory = value.toString();
                    final index = controller.requestCategoryModel?.category?.indexWhere((element) => element.name == controller.selectedCategory);
                    final id = controller.requestCategoryModel?.category![index!].categoryId;
                    title = controller.requestCategoryModel?.category![index!].name;
                    categoryId = id;
                    setState(() {});
                  },
                  items: controller.requestCategoryModel?.category?.map((item) => DropdownMenuItem<String>(
                    value: item.name,
                    child: Text(item.name ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                  )).toList(),
                  title: "Search for available services",
                ),
                const SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: StreamBuilder<String>(
                      stream: requestBLoc.requestID,
                      builder: (context, snapshot) {
                        return CustomButton(
                          onTap: () {
                            requestBLoc.addRequestID("");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return FetchedRequestScreen(
                                    id: categoryId.toString(),
                                    title: title,
                                  );
                                }));
                          },
                          enabled: categoryId != null ? true : false,
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
      );
    });
  }
}
