import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/jobCard.dart';

class jobs_Page extends StatefulWidget {
  const jobs_Page({Key? key}) : super(key: key);

  @override
  State<jobs_Page> createState() => _jobs_PageState();
}

class _jobs_PageState extends State<jobs_Page> {
  final _ctrl = Get.find<AccountController>();

  @override
  void initState() {
    _ctrl.getAllJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        builder: (controller){
      return Scaffold(
        appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
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
            title: Text("Jobs",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        backgroundColor: const Color(0XFFF8F8F8),
        body: controller.hasJobs == false ?
        const Center(
          child: CupertinoActivityIndicator(),
        ) : controller.jobResponseModel == null ||
            controller.jobResponseModel!.jobs!.isEmpty || controller.jobResponseModel!.jobs == [] ?
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/2.5,),
              Icon(Icons.hourglass_empty_outlined, color: primaryColor, size: 38,),
              const SizedBox(height: 20,),
              const Text('No Job Record', style: TextStyle(color: Colors.red),),
              SizedBox(height: MediaQuery.of(context).size.height/2.5,),
            ],
          ),
        ) :
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(controller.jobResponseModel!.jobs!.length, (index){
                  return jobs_Card(jobs: controller.jobResponseModel!.jobs![index],);
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
