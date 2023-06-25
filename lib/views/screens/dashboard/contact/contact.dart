import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_fields.dart';

class contact_Page extends StatefulWidget {
  const contact_Page({Key? key}) : super(key: key);

  @override
  State<contact_Page> createState() => _contact_PageState();
}

class _contact_PageState extends State<contact_Page> {
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
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
              title: Text("Contact Us",textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('We are available to support you all the way all the time.'),
                        const SizedBox(height: 5,),
                        const Text('Kindly reach out to us incase of any difficulty'),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Text("+234 (0) 8167438292", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: primaryColor, fontSize: 13, fontWeight: FontWeight.w500),),
                            const SizedBox(width: 10,),
                            Text("+234 (0) 9045649369", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: primaryColor, fontSize: 13, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text('handyhub@Gmail.com)'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlainTextField(
                          label: "Subject",
                          hint: "Typing is difficult",
                          controller: subjectController,
                        ),
                        PlainTextField3(
                          label: "Description",
                          hint: "...",
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 55),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    onTap: () {
                      controller.contactUs(subject: subjectController.text, message: descriptionController.text);
                    },
                    text: "send",
                    enabled: descriptionController.text.isEmpty || subjectController.text.isEmpty ? false : true,
                  ),
                ),
                const SizedBox(height: 85),
              ],
            ),
          ),
        ),
      );
    });
  }
}
