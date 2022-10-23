import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/auth_header.dart';
import 'package:esolink/views/widgets/custom_button.dart';
import 'package:esolink/views/widgets/custom_fields.dart';
import 'package:flutter/material.dart';

class ServiceProviderRegistration extends StatelessWidget {
  const ServiceProviderRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesBloc categoriesBloc = locator.get<CategoriesBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: ListView(children: [
          const AuthHeader(
            title: "Service Provider",
            subTitle: "You are registering as a service provider",
          ),
          const SizedBox(
            height: 39,
          ),
          PlainTextField(
            label: "Business Name",
            hint: "Matthew Adetoyese",
          ),
          StreamBuilder<List<CategoriesModel>>(
              initialData: [
                CategoriesModel.fromJson(
                  {
                    "categoryId": 14,
                    "name": " Architect",
                    "icon":
                        "https://res.cloudinary.com/esolink/image/upload/v1641928046/ikbniod9u9l4narj50aj.png",
                    "publicId": null,
                    "description": " Architect",
                    "supervisorName": "Fortune Johnbull",
                    "supervisorEmail": "goodyrhome@gmail.com ",
                    "supervisorNumber": "2349056309508",
                    "group": "B",
                    "active": null,
                    "deleted": null,
                    "createdBy": null,
                    "createdOn": null,
                    "updatedBy": null,
                    "updatedOn": null
                  },
                )
              ],
              stream: categoriesBloc.allCategories,
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data!.isEmpty) {
                  return const SizedBox();
                }
                return SelectField(
                  onchanged: (e) {
                    print(e);
                  },
                  value: "",
                  items: snapshot.data!
                      .map<dynamic>((CategoriesModel? e) => e)
                      .toList(),
                  hint: "Select Service Category",
                  label: "Type of Service",
                );
              }),
          PlainTextField(
            label: "Physical Address",
            hint: "23 Adegbite street, Sawmil, Ifako Ijaye",
          ),
          PlainTextField(
            label: "Phone Number",
            hint: "0909939939",
          ),
          PlainTextField(
            label: "Email Address",
            hint: "business@gmail.com",
          ),
          const PasswordField(
            label: "Password",
            hint: "password",
          ),
          const SizedBox(
            height: 40,
          ),
          const CustomButton(
            text: "Register",
          )
        ]),
      ),
    );
  }
}
