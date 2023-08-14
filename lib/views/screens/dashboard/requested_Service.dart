import 'package:esolink/logic/account/controller.dart';
import 'package:esolink/logic/api_services/local/local_storage.dart';
import 'package:esolink/logic/api_services/remote/network_servcises/dio_service_config/dio_client.dart';
import 'package:esolink/models/account/all_requested_services.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/screens/dashboard/requests/add_request.dart';
import 'package:esolink/views/widgets/request_Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class requested_Page extends StatefulWidget {
  const requested_Page({Key? key}) : super(key: key);

  @override
  State<requested_Page> createState() => _requested_PageState();
}

class _requested_PageState extends State<requested_Page> {
  final _controller = Get.find<AccountController>();
  int page = 1;
  final int _limit = 20;
  bool hasNextPage = true;
  bool isLoadingMoreData = false;
  bool _isFirstLoadRunning = false;
  late ScrollController _scrollController;

  Future<void> _loadMore() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    if(hasNextPage == true && _isFirstLoadRunning == false && isLoadingMoreData == false && _scrollController.position.extentAfter < 300){
      setState(() {
        isLoadingMoreData = true;
      });
      page += 1;
      try{
        var response = await NetworkProvider().call(path: "/Services/requested/services/by/customerId/pagination?PageNumber=$page&PageSize=$_limit&PageId=$customerId", method: RequestMethod.get,);
          final payLoad = AllRequestedServicesResponse.fromJson(response!.data).response?.data;
          if(payLoad!.isNotEmpty){
            setState(() {
              _controller.requestedServices?.addAll(payLoad);
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
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.fetchUserDetails();
    final customerId = userDetails.serviceProviders![0].serviceProviderId;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try{
      var response = await NetworkProvider().call(path: "/Services/requested/services/by/customerId/pagination?PageNumber=$page&PageSize=$_limit&PageId=$customerId", method: RequestMethod.get,);
      setState(() {
        _controller.requestedServices = AllRequestedServicesResponse.fromJson(response!.data).response?.data;
      });
    }catch(err){
      throw err.toString();
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }


  @override
  void initState() {
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        builder: (controller){
      return Scaffold(
        appBar: AppBar(
            backgroundColor: white, elevation: 0.0,
            leading: _controller.requestedServices!.isEmpty || _controller.requestedServices == [] ?
            const SizedBox() :
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20,),
                  ),
                )),
            title: Text("Requested Services",textAlign: TextAlign.center,
                style: subHeaderText.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
        ),
        backgroundColor: const Color(0XFFF8F8F8),
        body: _isFirstLoadRunning ?
            const Center(
              child: CupertinoActivityIndicator(),
            ) : _controller.requestedServices!.isEmpty || _controller.requestedServices == [] ?
        const AddRequest()
        : SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(_controller.requestedServices!.length, (index){
                  return requests_Card(requestedService: _controller.requestedServices![index]);
                }),
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
                  ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
