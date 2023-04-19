import 'package:esolink/logic/dashboard_controller.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/accounts/account_screen.dart';
import 'package:esolink/views/screens/dashboard/delivery/delivery_screen.dart';
import 'package:esolink/views/screens/dashboard/requests/request.dart';
import 'package:esolink/views/screens/dashboard/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import 'home/home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget>? body;
  GlobalKey<ScaffoldState> s = GlobalKey();

  @override
  void initState() {
    super.initState();
    body = [
      Homepage(),
      const StoreScreen(),
      const RequestScreen(),
      const DeliveryScreen(),
      const AccountScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
        builder: (controller){
      return Scaffold(
        key: s,
        body: body![controller.index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: white,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: controller.index == 0
                    ? Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "home",
                        color: primaryColor,
                        size: 15,
                      ),
                    ))
                    : Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "home",
                        size: 15,
                        color: Colors.black38,
                      ),
                    ))),
            BottomNavigationBarItem(
                label: "Store",
                icon: controller.index == 1
                    ? Container(
                    height: 37,
                    width: 37,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "store",
                        color: Color(0xff187226),
                        size: 15,
                      ),
                    ))
                    : Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "store",
                        size: 15,
                        color: Colors.black38,
                      ),
                    ))),
            BottomNavigationBarItem(
                label: "Request",
                icon: controller.index == 2
                    ? Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "request",
                        size: 15,
                        color: primaryColor,
                      ),
                    ))
                    : Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "request",
                        size: 15,
                        color: Colors.black38,
                      ),
                    ))),
            BottomNavigationBarItem(
                label: "Delivery",
                icon: controller.index == 3
                    ? Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "delivery",
                        size: 15,
                        color: primaryColor,
                      ),
                    ))
                    : Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "delivery",
                        size: 15,
                        color: Colors.black38,
                      ),
                    ))),
            BottomNavigationBarItem(
                label: "Accounts",
                icon: controller.index == 4
                    ? Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "account",
                        size: 15,
                        color: primaryColor,
                      ),
                    ))
                    : Container(
                    height: 37,
                    width: 37,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: EsolinkIcons(
                        icons: "account",
                        size: 15,
                        color: Colors.black38,
                      ),
                    ))),
          ],
          currentIndex: controller.index,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: primaryColor),
          selectedLabelStyle:
          subHeaderText.copyWith(color: Colors.black, fontSize: 10),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          unselectedLabelStyle:
          subHeaderText.copyWith(color: Colors.black, fontSize: 10),
          onTap: (e) {
           controller.switchTab(e);
          },
        ),
      );
    });
  }
}
