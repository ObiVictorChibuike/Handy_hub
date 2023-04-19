import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';

import 'back_button.dart';

class ViewProfileImage extends StatefulWidget {
  final String? imageUrl;
  const ViewProfileImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<ViewProfileImage> createState() => _ViewProfileImageState();
}

class _ViewProfileImageState extends State<ViewProfileImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white, elevation: 0.0,
              centerTitle: true,
              leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: EsolinkBackButton(),
                  )),
              title: Text("Photo",textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
          ),
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "HeroOne",
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2, width: MediaQuery.of(context).size.width,
                    child: Image.network(widget.imageUrl ?? imagePlaceHolder),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}




