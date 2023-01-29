import 'package:esolink/views/screens/dashboard/profile/personal.dart';
import 'package:esolink/views/screens/dashboard/profile/services.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        title: Text(
        'Profile',
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Color(0XFFE5E5E5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
                          indicatorWeight: 1,
                          indicator: BoxDecoration(
                            color: Color(0XFF187226),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: 'Personal',
                            ),
                            Tab(
                              text: 'Services',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      personal_Page(),
                      services_Page(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
