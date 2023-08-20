import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/logic/services_category/category_controller.dart';
import 'package:esolink/models/request_model/request_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/returned_requests_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchedRequestScreen extends StatefulWidget {
  const FetchedRequestScreen({Key? key, this.title, this.id}) : super(key: key);

  final String? title, id;

  @override
  State<FetchedRequestScreen> createState() => _FetchedRequestScreenState();
}

class _FetchedRequestScreenState extends State<FetchedRequestScreen> {
  int page = 1;
  final int _limit = 10;
  bool hasNextPage = true;
  bool isLoadingMoreData = false;
  bool _isFirstLoadRunning = false;
  List<RequestModelList>? requestModelList = <RequestModelList>[].obs;
  late ScrollController _scrollController;

  Future<void> _loadMore() async {
    if(hasNextPage == true && _isFirstLoadRunning == false && isLoadingMoreData == false
        && _scrollController.position.extentAfter < 300){
      setState(() {
        isLoadingMoreData = true;
      });
      page += 1;
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final long = await LocalCachedData.instance.getLatitude();
      final lat = await LocalCachedData.instance.getLongitude();
      try{
        var response = await NetworkProvider().call(path: "/Services/all/providers/by/category/pagination?PageNumber=$page&PageSize=$_limit&PageId=${widget.id}&Longitude=$long&Latitude=$lat", method: RequestMethod.get,);
        final payLoad = RequestsModel.fromJson(response!.data).response?.data;
        if(payLoad!.isNotEmpty){
          setState(() {
            requestModelList?.addAll(payLoad);
          });
        }else{
          setState(() {
            hasNextPage = false;
          });
        }
      }catch(err){
        throw err.toString();
      }
      setState(() {
        isLoadingMoreData = false;
      });
    }
  }

  void _firstLoad()async{
    setState(() {
      _isFirstLoadRunning = true;
    });
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final long = await LocalCachedData.instance.getLatitude();
    final lat = await LocalCachedData.instance.getLongitude();
    try{
      var response = await NetworkProvider().call(path: "/Services/all/providers/by/category/pagination?PageNumber=$page&PageSize=$_limit&PageId=${widget.id}&Longitude=$long&Latitude=$lat", method: RequestMethod.get,);
      setState(() {
        requestModelList = RequestsModel.fromJson(response!.data).response?.data;
      });
    }catch(err){
      throw err.toString();
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  final _ctrl = Get.find<CategoryController>();

  @override
  void initState() {
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        builder: (controller){
      return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white, elevation: 0.0,
              centerTitle: true,
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
              title: Text(widget.title!,textAlign: TextAlign.center,
                  style: subHeaderText.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))
          ),
          body: _isFirstLoadRunning ?
          const Center(
            child: CupertinoActivityIndicator(),
          ) : requestModelList!.isEmpty || requestModelList == [] ?
          const Center(child: Text('No Data Found', style: TextStyle(color: Colors.red),)) :
          RefreshIndicator(
            onRefresh: ()async{
              _firstLoad();
            },
            child: ListView(
              controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      ...requestModelList!.map((e) => ReturnedRequestCard(
                        serviceProviders: e,
                      )).toList(),
                    ]),
                  ),
                  if(isLoadingMoreData == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 30),
                      child: CupertinoActivityIndicator(),
                    ),
                  if(hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      color: Colors.white, child: const Center(
                      child: Text("You have fetched all the content"),
                    ),)
                ]),
          ));
    });
  }
}
