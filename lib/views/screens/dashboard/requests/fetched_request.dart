import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/request/request_calls.dart';
import 'package:esolink/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/request_model/request_model.dart';
import '../../../widgets/page_with_back_button.dart';
import '../../../widgets/returned_requests_card.dart';

class FetchedRequestScreen extends StatelessWidget {
  FetchedRequestScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;
  final RequestBLoc requestBLoc = locator.get<RequestBLoc>();
  final MakeRequestBloc makeRequestBloc = locator.get<MakeRequestBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageWithBackButton(
          onDispose: () async {
            await requestBLoc.addRequestID("");
            requestBLoc.dispose();
          },
          title: title,
          body: Expanded(
            child: ListView(children: [
              FutureBuilder<List<RequestsModel>>(
                  future: fetchAllRequest(context, id),
                  builder: (context, snapshot) {
                    while (!snapshot.hasData) {
                      print(snapshot.hasData);
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        ...snapshot.data!
                            .map((e) => ReturnedRequestCard(
                                  requestsModel: e,
                                ))
                            .toList()
                      ]),
                    );
                  })
            ]),
          ),
    ));
  }
}
