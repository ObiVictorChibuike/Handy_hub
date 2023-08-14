import 'dart:io';

import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? categoryId;

  Widget _descriptionForm({required String hintText, required TextEditingController descriptionController}){
    var maxLine = 11;
    return Container(height: maxLine * 17.0,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: const Color(0xffEFEFF0), border: Border.all(color: const Color(0xffBDBDBD))),
      child: TextFormField(
        controller: descriptionController,
        validator: (value){
          if (value!.split(" ").length > 40){
            return "Reached max words";
          }else{
            return null;
          }
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        maxLines: maxLine,
        decoration: const InputDecoration(
          fillColor: Color(0xffEFEFF0),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 0.7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 0.7)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 0.7)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 0.7)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.transparent, width: 0.7)),
        ),
      ),
    );
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  final _controller = Get.find<AccountController>();
  _showImagePickerDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<AccountController>(
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
                      if(index == 0 && controller.convertProduct1 != null){
                        setState(() {
                          _controller.photo1 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct1!}");
                        });
                        _controller.onUploadImage(ImageSource.camera, index);
                      }else if(index == 1 &&  controller.convertProduct2 != null){
                        setState(() {
                          _controller.photo2 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct2!}");
                        });
                        _controller.onUploadImage(ImageSource.camera, index);
                      }else if(index == 2 &&  controller.convertProduct3 != null){
                        setState(() {
                          _controller.photo3 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct3!}");
                        });
                        _controller.onUploadImage(ImageSource.camera, index);
                      }else if(index == 3 &&  controller.convertProduct4 != null){
                        setState(() {
                          _controller.photo3 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct4!}");
                        });
                        _controller.onUploadImage(ImageSource.camera, index);
                      }
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Choose from Gallery'),
                    onPressed: () async {
                      Get.back();
                      if(index == 0 && controller.convertProduct1 != null){
                        setState(() {
                          _controller.photo1 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct1!}");
                        });
                        _controller.onUploadImage(ImageSource.gallery, index);
                      }else if(index == 1 &&  controller.convertProduct2 != null){
                        setState(() {
                          _controller.photo2 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct2!}");
                        });
                        _controller.onUploadImage(ImageSource.gallery, index);
                      }else if(index == 2 &&  controller.convertProduct3 != null){
                        setState(() {
                          _controller.photo3 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct3!}");
                        });
                        _controller.onUploadImage(ImageSource.gallery, index);
                      }else if(index == 3 &&  controller.convertProduct4 != null){
                        setState(() {
                          _controller.photo4 = null;
                          _controller.images.remove("data:image/jpeg;base64,${controller.convertProduct4!}");
                        });
                        _controller.onUploadImage(ImageSource.gallery, index);
                      }else{
                        _controller.onUploadImage(ImageSource.gallery, index);
                      }
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

  bool? showAvailability = false;

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
              title: Text("Create Product",textAlign: TextAlign.center, style: subHeaderText.copyWith(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            body:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                  children: [
                PlainTextField(
                  controller: productNameController,
                  label: "Product Name",
                  hint: "name",
                ),
                PlainTextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: productAmountController,
                  label: "Product Amount",
                  hint: "amount",
                ),
                Align(alignment: Alignment.topLeft,
                  child: Text("Product Category",style: subHeaderText.copyWith(
                    fontSize: 15,
                  )),
                ),
                const SizedBox(height: 10,),
                DropDownTextField(
                  onChanged: (value) {
                    final index = controller.productCategoryResponse?.storeCategory?.indexWhere((element) => element.name == value.toString());
                    categoryId = controller.productCategoryResponse!.storeCategory![index!].categoryId.toString();
                  },
                  items: controller.productCategoryResponse?.storeCategory?.map((item) => DropdownMenuItem<String>(
                    value: item.name ?? "",
                    child: Text("${item.name}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                  )).toList(),
                  title: "",
                ),
                const SizedBox(height: 26,),
                Align(alignment: Alignment.topLeft,
                  child: Text("Product Description",style: subHeaderText.copyWith(
                    fontSize: 15,
                  )),
                ),
                const SizedBox(height: 10,),
                _descriptionForm(hintText: "description", descriptionController: productDescriptionController),
                    const SizedBox(height: 26,),
                    Align(alignment: Alignment.topLeft,
                      child: Text("Product Image",style: subHeaderText.copyWith(
                        fontSize: 15,
                      )),
                    ),
                const SizedBox(
                  height: 12,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1, crossAxisCount: 2, mainAxisSpacing: 10,
                    crossAxisSpacing: 10,),
                  itemCount: 4,
                  itemBuilder: (_,index){
                    return GestureDetector(
                      onTap: (){
                        _showImagePickerDialog(context, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffF7F7F7),
                        ),
                        // height: MediaQuery.of(context).size.height * .43,
                        width: MediaQuery.of(context).size.width * .42,
                        child: index == 0 && controller.photo1 != null ? Center(child: Image.file(File(controller.photo1!.path), fit: BoxFit.cover,)) : index == 1 && controller.photo2 != null ?Center(
                          child: Image.file(File(controller.photo2!.path), fit: BoxFit.cover,)) : index == 2 && controller.photo3 != null ? Center(child: Image.file(File(controller.photo3!.path), fit: BoxFit.cover,)) :
                        index == 3 && controller.photo4 != null ? Center(child: Image.file(File(controller.photo4!.path), fit: BoxFit.cover,)) : Icon(Icons.add, size: 45, color: primaryColor,)
                      ),
                    );
                  },
                ),
                    const SizedBox(height: 38.5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Product Availability",style: subHeaderText.copyWith(
                          fontSize: 15,
                        )),
                        CupertinoSwitch(value: showAvailability!, onChanged: (value){
                          setState(() {
                            showAvailability = value;
                          });
                        })
                      ],
                    ),
                    const SizedBox(height: 85.5,),
                    CustomButton(
                      onTap: () {
                        controller.addProduct(
                            productId: 0, name: productNameController.text,
                            amount: int.parse(productAmountController.text),
                            categoryId: int.parse(categoryId!), description: productDescriptionController.text,
                            status: showAvailability!, context: context
                        );
                      },
                      enabled: productNameController.text.isNotEmpty && productAmountController.text.isNotEmpty &&
                          categoryId != null && productDescriptionController.text.isNotEmpty && controller.images.isNotEmpty
                          ? true : false,
                      text: "Upload",
                    ),
                    const SizedBox(
                      height: 50,
                    ),
              ]),
            ),
          )
      );
    });
  }
}
