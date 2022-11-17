import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/icons/esolink_icons.dart';
import 'package:esolink/views/screens/dashboard/accounts/account_screen.dart';
import 'package:esolink/views/screens/dashboard/delivery/delivery_screen.dart';
import 'package:esolink/views/screens/dashboard/requests/request.dart';
import 'package:esolink/views/screens/dashboard/store/store.dart';
import 'package:flutter/material.dart';

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
  int index = 0;
  List<Widget>? body;
  GlobalKey<ScaffoldState> s = GlobalKey();

  @override
  void initState() {
    super.initState();
    body = [
      Homepage(),
      StoreScreen(),
      const RequestScreen(),
      const DeliveryScreen(),
      const AccountScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: s,
      body: body![index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: index == 0
                  ? Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "home",
                          color: white,
                          size: 15,
                        ),
                      ))
                  : Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF5F9F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "home",
                          size: 15,
                          color: primaryColor,
                        ),
                      ))),
          BottomNavigationBarItem(
              label: "Store",
              icon: index == 1
                  ? Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "store",
                          size: 15,
                          color: Colors.white,
                        ),
                      ))
                  : Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF5F9F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "store",
                          size: 15,
                          color: primaryColor,
                        ),
                      ))),
          BottomNavigationBarItem(
              label: "Request",
              icon: index == 2
                  ? Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "request",
                          size: 15,
                          color: white,
                        ),
                      ))
                  : Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF5F9F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "request",
                          size: 15,
                          color: primaryColor,
                        ),
                      ))),
          BottomNavigationBarItem(
              label: "Delivery",
              icon: index == 3
                  ? Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "delivery",
                          size: 15,
                          color: white,
                        ),
                      ))
                  : Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF5F9F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "delivery",
                          size: 15,
                          color: primaryColor,
                        ),
                      ))),
          BottomNavigationBarItem(
              label: "Accounts",
              icon: index == 4
                  ? Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "account",
                          size: 15,
                          color: white,
                        ),
                      ))
                  : Container(
                      height: 29,
                      width: 29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF5F9F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EsolinkIcons(
                          icons: "account",
                          size: 15,
                          color: primaryColor,
                        ),
                      ))),
        ],
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: primaryColor),
        selectedLabelStyle:
            subHeaderText.copyWith(color: Colors.black, fontSize: 10),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedLabelStyle:
            subHeaderText.copyWith(color: Colors.black, fontSize: 10),
        onTap: (e) {
          setState(() {
            index = e;
          });
        },
      ),
    );
  }
}
