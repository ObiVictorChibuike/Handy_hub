import 'dart:developer';

import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'back_button.dart';
import 'custom_scroll_physics.dart';

class ImageViewer extends StatefulWidget{
  final int imageCount;
  late int? selectedIndex;
  final  List<BusinessPhoto>? imageUrl;
  ImageViewer({Key? key, required this.imageCount, this.selectedIndex, this.imageUrl}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>  with SingleTickerProviderStateMixin{

  // PageController? controller;
  final ctrl = PageController();
  int? current;

  @override
  void initState() {
    current = widget.selectedIndex;
    setState(() {});
    // controller = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    // controller?.addListener(() {
    //   setState(() {
    //    widget.selectedIndex = controller!.page!.toInt();
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget indicator(){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imageUrl!.map((x) {
          final index = widget.imageUrl!.indexOf(x);
          return Container(
            width: 5.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: current == index
                  ? primaryColor
                  : Colors.grey.shade400,
            ),
          );
        }).toList(),
      );
    }

    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0, centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const EsolinkBackButton()),
            ),
            title: Text("Photos",
                textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,

                    fontWeight: FontWeight.bold)),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.imageUrl!.isEmpty ||
                  widget.imageUrl == [] ||
                  widget.imageUrl == null ?
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height/2.6, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: PageView.builder(
                        physics: const CustomPageViewScrollPhysics(),
                        itemCount: 6,
                        pageSnapping: true,
                        controller: ctrl,
                        onPageChanged: (page) {
                          setState(() {
                            current = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(imagePlaceHolder, fit: BoxFit.cover,),
                          );
                        }),
                  ),
                  Positioned(
                    right: 30,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                      child: Text("$current / ${6}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    ),
                  )
                ],
              ) :
              Stack(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height/2.6, width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: PageView.builder(
                          physics: const CustomPageViewScrollPhysics(),
                          itemCount: widget.imageUrl?.length,
                          pageSnapping: true,
                          controller: ctrl,
                          onPageChanged: (page) {
                            setState(() {
                              current = page;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(widget.imageUrl![pagePosition].photoUrl!, fit: BoxFit.cover,),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                      child: Text("${current ?? 0 + 1} / ${widget.imageUrl!.length}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    ),
                  )
                ],
              ),
              indicator(),
              const SizedBox(height: 70,)
            ],
          ),
        )
    );
  }
}
