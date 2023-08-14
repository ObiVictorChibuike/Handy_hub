import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/profile/personal.dart';
import 'package:esolink/views/screens/dashboard/profile/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class profile_creen extends StatelessWidget {
//   const profile_Screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Profile',
//           style:
//           TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: TabBar(
//                 indicatorSize: TabBarIndicatorSize.label,
//                 indicatorColor: Color(0XFFF88E07),
//                 labelColor: Color(0XFFF88E07),
//                 unselectedLabelColor: Colors.black,
//                 isScrollable: true,
//                 labelPadding: EdgeInsets.symmetric(horizontal: 30.0),
//                 tabs: [
//                   Tab(text: 'Personal'),
//                   Tab(text: 'Services'),
//                 ]),
//       T,
//       );
//   }
// }

class profile_Screen extends StatefulWidget {
  const profile_Screen({Key? key}) : super(key: key);

  @override
  _profile_ScreenState createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _ctrl = Get.find<AccountController>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _ctrl.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
            title: Text("Profile",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        backgroundColor: const Color(0XFFF8F8F8),
        body: controller.hasProfile == false && controller.profileResponse == null ||
            controller.profileResponse!.serviceProviders!.isEmpty && controller.profileResponse!.serviceProviders == [] ?
        const Center(
          child: CupertinoActivityIndicator(),
        ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              SizedBox(height: 30,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorWeight: 1,
                  indicator: BoxDecoration(
                    color: const Color(0XFF187226),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  controller: tabController,
                  tabs: [
                    const Tab(
                      text: 'Personal',
                    ),
                    controller.profileResponse!.serviceProviders![0].customerTypeId == 1 ? const SizedBox() :
                    const Tab(
                      text: 'Services',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    personal_Page(serviceProvider: controller.profileResponse!.serviceProviders![0],),
                    controller.profileResponse!.serviceProviders![0].customerTypeId == 2 ?
                    services_Page(serviceProvider: controller.profileResponse!.serviceProviders![0],) :  const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
