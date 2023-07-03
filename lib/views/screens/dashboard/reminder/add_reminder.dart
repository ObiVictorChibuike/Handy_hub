import 'dart:developer';

import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/services_category/category_controller.dart';
import 'package:esolink/logic/services_category/reminder_response_controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  late DateTime _selectedDate = DateTime.now();
  final dateController = TextEditingController();
  final serviceProviderType = TextEditingController();
  final serviceProvider = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      helpText: 'SELECT YOUR DATE OF BIRTH',
      confirmText: 'SELECT',
    );
    if (picked != null ) {
      setState(() {
        _selectedDate = picked;
        dateController.text = getDate(_selectedDate.toString());
      });
    }
  }
  final reminderController = Get.put(ReminderResponseController());

  getDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
  final _controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller){
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
              child: ListView(children: [
                const AuthHeader(
                  title: "Reminder",
                  subTitle: "",
                ),
                const SizedBox(height: 25,),
                PlainTextField(
                  readOnly: true,
                  controller: dateController,
                  label: "Date",
                  hint: "DD/MM/YYYY",
                  onTap: ()=> _selectDate(context),
                ),
                Align(alignment: Alignment.topLeft,
                  child: Text("Type of Services",style: subHeaderText.copyWith(
                    fontSize: 15,
                  )),
                ),
                const SizedBox(height: 10,),
                DropDownTextField(
                  onChanged: (value) {
                    final index = controller.categories.indexWhere((element) => element.name == value.toString());
                    reminderController.getAllReminderServices(categoryId: controller.categories[index].categoryId.toString());
                    serviceProviderType.text = controller.categories[index].categoryId.toString();
                    setState(() {});
                  },
                  items: controller.categories.map((item) => DropdownMenuItem<String>(
                    value: item.name ?? "",
                    child: Text("${item.name}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                  )).toList(),
                  title: "Select Service Category",
                ),
                const SizedBox(
                  height: 26,
                ),
                    GetBuilder<ReminderResponseController>(
                      init: ReminderResponseController(),
                        builder: (controller){
                      return  controller.isLoadingAllServices == true ?
                      const Center(child: CupertinoActivityIndicator()) :
                        Column(
                        children: [
                          Align(alignment: Alignment.topLeft,
                            child: Text("Service Provider",style: subHeaderText.copyWith(
                              fontSize: 15,
                            )),
                          ),
                          const SizedBox(height: 10,),
                          DropDownTextField(
                            onChanged: (value) {
                              final index = controller.requestModelList?.indexWhere((element) => element.firstName == value.toString());
                              serviceProvider.text = controller.requestModelList![index!].serviceProviderId!.toString();
                            },
                            items: controller.requestModelList?.map((item) => DropdownMenuItem<String>(
                              value: item.firstName,
                              child: Text("${item.firstName} - ${item.distance}",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                            )).toList(),
                            title: "Select Service Provider",
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: (){
                    if(dateController.text.isEmpty || serviceProviderType.text.isEmpty || serviceProvider.text.isEmpty ){
                      null;
                    }else{
                      _controller.addReminder(reminderId: 0, serviceProviderId: int.parse(serviceProvider.text),
                          categoryId: int.parse(serviceProviderType.text), datetime: dateController.text,
                          reminderStatus: 1);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 45, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text("Add", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
