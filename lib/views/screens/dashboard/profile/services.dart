import 'dart:io';

import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/account/profile_response.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/custom_button.dart';

class services_Page extends StatefulWidget {
  final ServiceProvider? serviceProvider;
  const services_Page({Key? key, this.serviceProvider}) : super(key: key);

  @override
  State<services_Page> createState() => _services_PageState();
}

class _services_PageState extends State<services_Page> {

  _showImagePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<AccountController>(
            init: AccountController(),
            builder: (controller){
              return SimpleDialog(
                backgroundColor: Colors.white,
                title: Text('Upload Image', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),),
                children: [
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Take a photo'),
                    onPressed: () async {
                      Get.back();
                      controller.onAddServiceImage(ImageSource.camera);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Choose from Gallery'),
                    onPressed: () async {
                      Get.back();
                      controller.onAddServiceImage(ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }

  showAlertDialog({required void Function() onPressed}){
    showDialog(context: context,
      builder: (context) => CleanDialog(
        title: 'Confirm Request',
        content: 'Are you sure you want to delete this item?',
        backgroundColor:  primaryColor,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 13, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'Accept',
            textColor: primaryColor,
            onPressed: onPressed,
          ),
          CleanDialogActionButtons(
            actionTitle: 'Cancel',
            textColor: const Color(0xffbe3a2c),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          GridView.builder(shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.2, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,),
            itemCount: widget.serviceProvider!.businessPhoto!.length,
            itemBuilder: (context,index){
              final item = widget.serviceProvider!.businessPhoto![index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(item.photoUrl ?? imagePlaceHolder),
                                    fit: BoxFit.cover
                                ),
                              ),)),
                        GestureDetector(
                          onTap: (){
                            showAlertDialog(onPressed: (){
                              Get.back();
                              controller.deleteServicePhoto(productId: item.businessPhotoIdId.toString());
                            });
                          },
                          child: Container(
                            height: 20, width: 20,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Center(child: Icon(Icons.clear, color: Colors.black, size: 15,)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          controller.serviceImages.isEmpty || controller.serviceImages == [] ? const SizedBox() :
          Column(
            children: [
              Align(alignment: Alignment.centerLeft,
                  child: Text("Added Images", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),)),
              GridView.builder(shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.2, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,),
                itemCount: controller.serviceImages.length,
                itemBuilder: (context,index){
                  final item = controller.serviceImages[index];
                  return Padding(padding: const EdgeInsets.all(12.0),
                    child: Wrap(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(8),
                                child: Container(
                                    height: 150, width: 200,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),),
                                    child: Image.file(File(item.path), fit: BoxFit.cover,
                                    ))
                            ),
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  controller.serviceImages.removeAt(index);
                                });
                              },
                              child: Container(
                                height: 25, width: 25,
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, ),
                                child: const Center(child: Icon(Icons.clear),),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              _showImagePickerDialog(context);
            },
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffF7F7F7),),
                height: 150, width: 200,
                child: Icon(Icons.add, size: 45, color: primaryColor,)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              onTap: () {
                if(controller.serviceImages.isNotEmpty || controller.serviceImages != [] && widget.serviceProvider!.businessPhoto!.isNotEmpty){
                  controller.updateServiceImages(imageUrl: widget.serviceProvider!.businessPhoto!.map((e) => e.photoUrl).toList());
                }else{
                  null;
                }
              },
              text: "Save",
            ),
          ),
          const SizedBox(height: 40,),
        ],
      );
    });
  }
}
