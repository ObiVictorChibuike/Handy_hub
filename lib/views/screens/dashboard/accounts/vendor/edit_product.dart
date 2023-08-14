import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:esolink/views/widgets/custom_snack.dart';
import 'package:esolink/views/widgets/drop_down_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../models/account/all_products_response.dart';

class EditProduct extends StatefulWidget {
  final String productName;
  final String productDescription;
  final String productAmount;
  final List<PhotoUrlList>? imageUrl;
  final int productId;
  final int categoryId;
  final String? productCategory;
  final bool? status;
  const EditProduct({Key? key,
    required this.productName,
    required this.productDescription,
    required this.productAmount,
    // required this.imageUrl,
    required this.productId,
    required this.categoryId,
    this.productCategory,
    this.status, this.imageUrl}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  int? categoryId;
  int? productId;
  String? productCategory;

  @override
  void initState() {
    productNameController.text = widget.productName;
    productAmountController.text = widget.productAmount;
    productDescriptionController.text = widget.productDescription;
    productId = widget.productId;
    categoryId = widget.categoryId;
    productCategory = widget.productCategory;
    log("This is the product category $productCategory");
    showAvailability = widget.status ?? false;
    setState(() {});
    super.initState();
  }

  // Future<File> getImage({required String url}) async {
  //   final dio.Response res = await dio.Dio().get<List<int>>(
  //     url, options: dio.Options(
  //     responseType: dio.ResponseType.bytes,
  //   ),);
  //   final Directory appDir = await getApplicationDocumentsDirectory();
  //   final String imageName = url.split('/').last;
  //   final File file = File(path.join(appDir.path, imageName));
  //   file.writeAsBytesSync(res.data as List<int>);
  //   XFile xFile = XFile(file.path);
  //   setState(() {});
  //   return file;
  // }

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

  _showImagePickerDialog(BuildContext context) async {
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
                      controller.onAddProductImage(ImageSource.camera);
                      setState(() {});
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Choose from Gallery'),
                    onPressed: () async {
                      Get.back();
                      controller.onAddProductImage(ImageSource.gallery);
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
  bool? showAvailability;
  final _controller = Get.find<AccountController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
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
                  title: Text("Edit Product Details",textAlign: TextAlign.center, style: subHeaderText.copyWith(
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
                            categoryId = controller.productCategoryResponse!.storeCategory![index!].categoryId;
                            productCategory = controller.productCategoryResponse!.storeCategory![index].name;
                          },
                          items: controller.productCategoryResponse?.storeCategory?.map((item) => DropdownMenuItem<String>(
                            value: item.name ?? "",
                            child: Text("${item.name}",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 15)),
                          )).toList(),
                          title: productCategory,
                        ),
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
                          itemCount: widget.imageUrl!.length,
                          itemBuilder: (_,index){
                            return Stack(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: const Color(0xffF7F7F7),
                                      ),
                                      width: MediaQuery.of(context).size.width * .42,
                                      child: Image.network(widget.imageUrl![index].photoUrl ?? imagePlaceHolder)
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    showAlertDialog(onPressed: (){
                                      Get.back();
                                      controller.deletePhoto(id: widget.imageUrl![index].productPhotoIdId.toString());
                                    });
                                  },
                                  child: Container(
                                    height: 20, width: 20,
                                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    child: const Center(child: Icon(Icons.clear, color: Colors.black, size: 15,)),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20,),
                        controller.productImages.isEmpty || controller.productImages == [] ? const SizedBox() :
                        Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,
                                child: Text("Added Images", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),)),
                            GridView.builder(shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 1.2, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,),
                              itemCount: controller.productImages.length,
                              itemBuilder: (context,index){
                                final item = controller.productImages[index];
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
                                                controller.productImages.removeAt(index);
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
                            if(categoryId == null){
                              showErrorSnackBar(context,
                                  title: "Oops!",
                                  content: "Please select product category"
                              );
                            }else{
                              List<String?> loadedImages = <String>[].obs;
                              loadedImages = widget.imageUrl!.map((e) => e.photoUrl).toList();
                              List<String> images = <String>[].obs;
                              images = controller.productImages.map((e) => "data:image/jpeg;base64,${base64Encode(File(e.path).readAsBytesSync())}").toList();
                              controller.editProduct(productId: productId!, name: productNameController.text,
                                  amount: num.parse(productAmountController.text), categoryId: categoryId!, description: productDescriptionController.text,
                                  status: showAvailability!, context: context, images: [
                                    ...loadedImages,
                                    ...images,
                                  ]).then((value){
                                controller.productImages.clear();
                              });
                            }
                          },
                          enabled: true,
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
