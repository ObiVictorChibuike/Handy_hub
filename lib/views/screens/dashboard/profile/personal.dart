import 'dart:io';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/account/profile_response.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class personal_Page extends StatefulWidget {
  final ServiceProvider? serviceProvider;
  const personal_Page({Key? key, this.serviceProvider}) : super(key: key);

  @override
  State<personal_Page> createState() => _personal_PageState();
}

class _personal_PageState extends State<personal_Page> {
  final descriptionController = TextEditingController();
  @override
  void initState() {
    descriptionController.text = widget.serviceProvider?.description ?? "";
    setState(() {});
    super.initState();
  }

  Widget _descriptionForm(){
    var maxLine = 11;
    return Container(height: maxLine * 13.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Color(0xffE6E6E6),),
      child: TextFormField(
        controller: descriptionController,
        cursorHeight: 22, textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next, keyboardType: TextInputType.text,
        maxLines: maxLine,
        style:  const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Describe your business to your audience",
          hintStyle: const TextStyle(
            color: Color(0xff9C9C9C),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xff9C9C9C),
              width: 0.7,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
              const BorderSide(color: Color(0xff868484))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xff868484),
              width: 0.7,
            ),
          ),
          fillColor: Color(0xffE6E6E6),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  _showImagePickerDialog(BuildContext context) async {
    return showDialog(context: context,
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
                      controller.onUploadProfileImage(ImageSource.camera);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Choose from Gallery'),
                    onPressed: () async {
                      Get.back();
                      controller.onUploadProfileImage(ImageSource.gallery);
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

  Future<XFile> getImage({required String url, required AccountController controller}) async {
    /// Get Image from server
    final dio.Response res = await dio.Dio().get<List<int>>(
      url, options: dio.Options(
      responseType: dio.ResponseType.bytes,
    ),);
    /// Get App local storage
    final Directory appDir = await getApplicationDocumentsDirectory();
    /// Generate Image Name
    final String imageName = url.split('/').last;
    /// Create Empty File in app dir & fill with new image
    final File file = File(join(appDir.path, imageName));
    file.writeAsBytesSync(res.data as List<int>);
    XFile xFile = XFile(file.path);
    return xFile;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
        builder: (controller){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SingleChildScrollView(

            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: const Color(0XFFE5E5E5), borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  controller.imageFile == null ? _showImagePickerDialog(context) : setState(()=> controller.imageFile = null);
                                },
                                child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 80, width: 80,
                                    decoration: const BoxDecoration(shape: BoxShape.circle,),
                                    child: controller.imageFile == null ? Image.network(widget.serviceProvider?.photoUrl ?? imagePlaceHolder): Image.file(File(controller.imageFile!.path), fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(controller.imageFile == null ? "Tap to change picture" : "Tap to remove picture")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Align(alignment: Alignment.centerLeft,
                    child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                const SizedBox(height: 10,),
                widget.serviceProvider?.customerTypeId == 2 ? _descriptionForm() : const SizedBox(),
                widget.serviceProvider?.customerTypeId == 2 ? const SizedBox(height: 10,) : const SizedBox(),
                widget.serviceProvider?.customerTypeId == 2 ? CustomButton(
                  onTap: () async {
                    if(widget.serviceProvider?.description != descriptionController.text){
                      controller.updateProfile(
                        description: descriptionController.text,
                      );
                    }else{
                      null;
                    }
                  },
                  text: "Save",
                ) : const SizedBox(),
                const SizedBox(height: 18,),
                // Container(
                //   width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 8),
                //   decoration: BoxDecoration(border: Border.all(color: primaryColor),
                //       color: Colors.white, borderRadius: BorderRadius.circular(5)),
                //   child: Center(
                //     child: Text('http://esolink.com/invite', style: Theme.of(context).textTheme.bodyLarge?.
                //     copyWith(color: primaryColor, fontWeight: FontWeight.w500,),),
                //   ),
                // ),
                // const SizedBox(height: 10,),
                // Container(
                //   width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 8),
                //   decoration: BoxDecoration(border: Border.all(color: primaryColor),
                //       color: primaryColor, borderRadius: BorderRadius.circular(5)),
                //   child: Center(
                //     child: Text('Refer a friend', style: Theme.of(context).textTheme.bodyLarge?.
                //     copyWith(color: Colors.white, fontWeight: FontWeight.w500,),),
                //   ),
                // ),
                // const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Business Name:'),
                      const Spacer(),
                      Expanded(child: Text(widget.serviceProvider?.firstName ?? "No Name Specified")),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                widget.serviceProvider?.customerTypeId == 1 ? const SizedBox() : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Type of Service:'),
                      const Spacer(),
                      Expanded(child: Text(widget.serviceProvider?.category ?? "")),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Physical Address:'),
                      const Spacer(),
                      Expanded(child: Text(widget.serviceProvider?.address ?? "", overflow: TextOverflow.fade,)),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Phone Number:'),
                      const Spacer(),
                      Expanded(child: Text(widget.serviceProvider?.phoneNumber ?? "")),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Address:'),
                      const Spacer(),
                      Expanded(child: Text(widget.serviceProvider?.address ?? "")),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Referral Code:'),
                      const Spacer(),
                      Expanded(child:  Row(
                        children: [
                          Text(widget.serviceProvider?.referralCode ?? "no referral"),
                          const SizedBox(width: 5,),
                          widget.serviceProvider?.referralCode == null ? const SizedBox() :
                          GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(text: widget.serviceProvider!.referralCode!)).then((value){
                                  Fluttertoast.showToast(
                                    msg: "Copied to clipboard", toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1,
                                    textColor: Colors.white, fontSize: 14.0,
                                  );
                                });
                              }, child: const Icon(Icons.copy, color: Colors.black,))
                        ],
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
