import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/icon_box.dart';
import 'package:flutter/material.dart';

class SignUpSelectionTile extends StatelessWidget {
  const SignUpSelectionTile({Key? key, this.subTitle, this.title})
      : super(key: key);

  final String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    RegistrationBloc registrationBloc = locator.get<RegistrationBloc>();
    return StreamBuilder<String>(
        stream: registrationBloc.userType,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              registrationBloc.addUserType(title);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35.7),
              child: Container(
                // height: 86,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: snapshot.data == title ? primaryColor : Colors.transparent),
                    borderRadius: BorderRadius.circular(6),
                    color: snapshot.data == title
                        ? white
                        : const Color(0xffF7F7F7)),
                child: Row(
                  children: [
                   Builder(builder: (controller){
                     if(title == "Customer"){
                       return IconBox(
                         image: "user",
                         color: snapshot.data == title ? primaryColor : boldTextColor,
                       );
                     }else if(title == "Service Provider"){
                       return IconBox(
                         image: "gear",
                         color: snapshot.data == title ? primaryColor : boldTextColor,
                       );
                     }else if(title == "Store Vendor"){
                       return IconBox(
                         image: "vendor",
                         color: snapshot.data == title ? primaryColor : boldTextColor,
                       );
                     }else{
                       return IconBox(
                         image: "rider",
                         color: snapshot.data == title ? primaryColor : boldTextColor,
                       );
                     }
                   }),
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title",
                          style: subHeaderText,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          constraints: const BoxConstraints(
                              maxHeight: 38, maxWidth: 200),
                          child: Text(
                            "$subTitle",
                            style: subHeaderText.copyWith(fontSize: 14),
                          ),
                        )
                      ],
                    ),
               
                    const Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
