import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_decoration.dart';
import 'Image_view.dart';
import 'image_slider.dart';


class ImageCard extends StatefulWidget {
  final ServiceProvider? serviceProviders;
  const ImageCard({Key? key, this.serviceProviders}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerLeft,
              child: Text("Available Service", style: subHeaderText.copyWith(fontSize: 14, fontWeight: FontWeight.w500),)),
          const SizedBox(height: 8,),
          widget.serviceProviders!.businessPhoto!.isEmpty ||
              widget.serviceProviders?.businessPhoto == [] ||
              widget.serviceProviders?.businessPhoto == null ?
          const ImageSlider(imageUrl: imagePlaceHolder, imageLength: 6,) :
          SingleChildScrollView(scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
            child: Row(
              children: widget.serviceProviders?.businessPhoto?.map((item) =>
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          ImageViewer(imageCount: widget.serviceProviders!.businessPhoto!.length,
                            imageUrl: widget.serviceProviders!.businessPhoto,
                              selectedIndex: widget.serviceProviders!.businessPhoto!.indexOf(item),
                          )));
                    },
                child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 100, width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: item.photoUrl!,
                              placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                            //Image.network(item.photoUrl?? "", fit: BoxFit.cover, height: 100, width: 100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList() ?? [],
            ),
          )
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(children: const [
          //     PhotoCard(),
          //     PhotoCard(),
          //     PhotoCard(),
          //     PhotoCard(),
          //     PhotoCard(),
          //   ]),
          // ),

        ],
      ),
    );
  }
}
