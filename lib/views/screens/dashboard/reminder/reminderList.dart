import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/delivery/add_delivery.dart';
import 'package:esolink/views/screens/dashboard/reminder/add_reminder.dart';
import 'package:esolink/views/screens/dashboard/reminder/reminderScreen.dart';
import 'package:esolink/views/widgets/reminderCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class reminder_List extends StatefulWidget {
  const reminder_List({Key? key}) : super(key: key);

  @override
  State<reminder_List> createState() => _reminder_ListState();
}

class _reminder_ListState extends State<reminder_List> {
  bool? loginStatus;
  Future<bool> checkLoginStatus() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final isLoggedIn = await LocalCachedData.instance.getLoginStatus();
    loginStatus = isLoggedIn;
    return isLoggedIn;
  }
  final _ctrl = Get.put(AccountController());
  @override
  void initState() {
    checkLoginStatus();
    _ctrl.getAllReminder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return Scaffold(
        floatingActionButton: loginStatus == true && controller.allReminderResponse == null ||
            controller.allReminderResponse!.reminder!.isEmpty || controller.allReminderResponse!.reminder! == [] ?
            const SizedBox() :
        loginStatus == true && controller.allReminderResponse != null ||
            controller.allReminderResponse!.reminder!.isNotEmpty || controller.allReminderResponse!.reminder! != [] ?
        FloatingActionButton(onPressed: (){
          Get.to(()=> const AddReminder());
        }, child: const Icon(Icons.add, color: Colors.white,),)
            : const SizedBox(),
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
            title: Text("Reminder",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        body:
        controller.hasReminder == false ?
        const Center(
          child: CupertinoActivityIndicator(),
        ) : controller.allReminderResponse == null ||
            controller.allReminderResponse!.reminder!.isEmpty || controller.allReminderResponse!.reminder! == [] ?
        const reminder_Page() :
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(controller.allReminderResponse!.reminder!.length, (index){
                  return reminder_Card(reminder: controller.allReminderResponse!.reminder![index],);
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
