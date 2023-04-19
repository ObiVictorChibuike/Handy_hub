import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/logic/services_category/category_controller.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/request_model/request_model.dart';
import '../../../widgets/page_with_back_button.dart';
import '../../../widgets/returned_requests_card.dart';

class FetchedRequestScreen extends StatefulWidget {
  const FetchedRequestScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;

  @override
  State<FetchedRequestScreen> createState() => _FetchedRequestScreenState();
}

class _FetchedRequestScreenState extends State<FetchedRequestScreen> {
  final RequestBLoc requestBLoc = locator.get<RequestBLoc>();

  final MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();
  final _ctrl = Get.put(CategoryController());

  @override
  void initState() {
    _ctrl.fetchAllRequest(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: CategoryController(),
        builder: (controller){
      return Scaffold(
          body: PageWithBackButton(
            title: widget.title,
            body: Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                  children: [
                controller.isLoadingAllRequest == true ?
              const Center(child: CupertinoActivityIndicator()) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    ...controller.serviceProviders!.map((e) => ReturnedRequestCard(
                      serviceProviders: e,
                    )).toList(),
                  ]),
                ),
              ]),
            ),
          ));
    });
  }
}
