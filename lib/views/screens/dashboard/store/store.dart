import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:esolink/logic/store/stores_request.dart';
import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/service_locator.dart';
import 'package:esolink/views/widgets/page_with_back_button.dart';
import 'package:flutter/material.dart';
import '../../../constants/text_decoration.dart';
import '../../../widgets/stores_card.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key? key}) : super(key: key);

  final StoresBLoc storesBLoc = locator.get<StoresBLoc>();
  @override
  Widget build(BuildContext context) {
    fetchAllStoresCategories(context);
    return Scaffold(
      body: PageWithBackButton(
        title: "Stores",
        automaticallyImplyLeading: false,
        action: const Icon(Icons.search),
        body: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Store01(name: 'Super Market',),
                    Store01(name: 'Home & Office',),
                  ],
                ),
                store02(name: 'Hair Products',),
              ],
            ),
            Row(
              children: [
                store03(name: 'Computer/Phone accessories',),
                Column(
                  children: [
                    store04(name: 'Jewelries/Accesspries',),
                    store04(name: 'Electronics',),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Store01(name: 'Men/Women Wears',),
                    Store01(name: 'Baby/Teen Products',),
                  ],
                ),
                store02(name: 'MakeUp',),
              ],
            ),
            Row(
              children: [
                store03(name: 'Sport Shop',),
                Column(
                  children: [
                    store04(name: 'AutoMobile',),
                    store04(name: 'Thrift Shop',),
                  ],
                ),
              ],
            ),
          ],
        ),
        // body: StreamBuilder<List<StoresCategory>>(
        //     stream: storesBLoc.storesCategories,
        //     builder: (context, snapshot) {
        //       while (!snapshot.hasData) {
        //         return const CircularProgressIndicator();
        //       }
        //       return Expanded(
        //         child: SingleChildScrollView(
        //           child: Column(children: [
        //             ...snapshot.data!.map((e) {
        //               return StoresCard(stores: e, height: null,);
        //             }).toList()
        //           ]),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}

class store04 extends StatelessWidget {
  const store04({
    Key? key, required this.name
  }) : super(key: key);
  
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    // return StoresProduct(
    // id: stores!.categoryId,
    // );
    // }));
    },
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
    child: Stack(children: [
    // Container(
    //   height: 113 * .5,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       gradient: LinearGradient(
    //           // begin: FractionalOffset.topCenter,
    //           // end: FractionalOffset.bottomCenter,
    //           colors: [
    //             Colors.white,
    //             Colors.white.withOpacity(.95),
    //           ], stops: const [
    //         0.0,
    //         1.0
    //       ])),
    // ),
    ShaderMask(
    shaderCallback: (Rect bounds){
    return LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomCenter,
    colors: [
    Colors.white,
    Colors.transparent
    ]).createShader(bounds);
    },
    child: Container(
    height: 100,
    width: MediaQuery.of(context).size.width/1.8,
    decoration: BoxDecoration(
    border:
    Border.all(color: const Color(0xff187226)),
    borderRadius: BorderRadius.circular(10),
    image: const DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage("assets/images/car.png"))),
    ),
    ),
    Positioned(
    bottom: 5,
    left: 15,
    child: Text(
    "${name}",
    style: subHeaderText.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xff4F4F4F)),
    ),
    ),
    ]),
    ),
    );
  }
}

class store03 extends StatelessWidget {
  const store03({
    Key? key,required this.name
  }) : super(key: key);
  
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return StoresProduct(
    //     id: stores!.categoryId,
    //   );
    // }));
    },
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Stack(children: [
    // Container(
    //   height: 113 * .5,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       gradient: LinearGradient(
    //           // begin: FractionalOffset.topCenter,
    //           // end: FractionalOffset.bottomCenter,
    //           colors: [
    //             Colors.white,
    //             Colors.white.withOpacity(.95),
    //           ], stops: const [
    //         0.0,
    //         1.0
    //       ])),
    // ),
    ShaderMask(
    shaderCallback: (Rect bounds){
    return LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomCenter,
    colors: [
    Colors.white,
    Colors.transparent
    ]).createShader(bounds);
    },
    child: Container(
    height: 210,
    width: MediaQuery.of(context).size.width/3.5,
    decoration: BoxDecoration(
    border:
    Border.all(color: const Color(0xff187226)),
    borderRadius: BorderRadius.circular(10),
    image: const DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage("assets/images/car.png"))),
    ),
    ),
    Positioned(
    bottom: 5,
    left: 15,
    child: Text(
    "${name}",
    style: subHeaderText.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xff4F4F4F)),
    ),
    ),
    ]),
    ),
    );
  }
}

class store02 extends StatelessWidget {
  const store02({
    Key? key, required this.name
  }) : super(key: key);
  
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return StoresProduct(
        //     id: stores!.categoryId,
        //   );
        // }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
        child: Stack(children: [
          // Container(
          //   height: 113 * .5,
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       gradient: LinearGradient(
          //           // begin: FractionalOffset.topCenter,
          //           // end: FractionalOffset.bottomCenter,
          //           colors: [
          //             Colors.white,
          //             Colors.white.withOpacity(.95),
          //           ], stops: const [
          //         0.0,
          //         1.0
          //       ])),
          // ),
          ShaderMask(
            shaderCallback: (Rect bounds){
              return LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent
                  ]).createShader(bounds);
            },
            child: Container(
              height: 210,
              width: MediaQuery.of(context).size.width/3.5,
              decoration: BoxDecoration(
                  border:
                  Border.all(color: const Color(0xff187226)),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/car.png"))),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 15,
            child: Text(
              "${name}",
              style: subHeaderText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff4F4F4F)),
            ),
          ),
        ]),
      ),
    );
  }
}

class Store01 extends StatelessWidget {
  const Store01({
    Key? key,required this.name
  }) : super(key: key);
  
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      // return StoresProduct(
      // id: stores!.categoryId,
      // );
      // }));
      },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
          child: Stack(children: [
    // Container(
    //   height: 113 * .5,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       gradient: LinearGradient(
    //           // begin: FractionalOffset.topCenter,
    //           // end: FractionalOffset.bottomCenter,
    //           colors: [
    //             Colors.white,
    //             Colors.white.withOpacity(.95),
    //           ], stops: const [
    //         0.0,
    //         1.0
    //       ])),
    // ),
    ShaderMask(
      shaderCallback: (Rect bounds){
        return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.transparent
            ]).createShader(bounds);
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width/1.8,
        decoration: BoxDecoration(
            border:
            Border.all(color: const Color(0xff187226)),
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/car.png"))),
      ),
    ),
    Positioned(
      bottom: 5,
      left: 15,
      child: Text(
        "${name}",
        style: subHeaderText.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4F4F4F)),
      ),
    ),
          ]),
        ),
      );
  }
}