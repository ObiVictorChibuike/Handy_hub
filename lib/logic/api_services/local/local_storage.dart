import 'dart:convert';

import 'package:esolink/models/auth_model/auth_user_response.dart';
import 'package:esolink/models/service_provider_response_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  Future<String?> getAuthToken() async {
    String? token = _prefs.getString("token");
    return token;
  }

  Future<void> cacheAuthToken({required String? token}) async {
    _prefs.setString("token", token!);
  }

  Future<int?> getCustomerId() async {
    int? id = _prefs.getInt("CustomerId");
    return id;
  }

  Future<void> cacheCustomerId({required int? id}) async {
    _prefs.setInt("CustomerId", id!);
  }

  Future<String?> getCustomerEmail() async {
    String? email = _prefs.getString("email");
    return email;
  }

  Future<void> cacheCustomerEmail({required String? email}) async {
    _prefs.setString("email", email!);
  }

  Future<void> cacheHasOnBoardedStatus({required bool? hasOnBoarded}) async {
    _prefs.setBool("onboarded_status", hasOnBoarded!);
  }

  Future <bool?> getHasOnBoardedStatus() async {
    bool? onBoardedStatus = _prefs.getBool("onboarded_status");
    return onBoardedStatus;
  }

  Future<void> cacheLaundryCategoryList({required List<String>? category}) async {
    _prefs.setStringList("laundry_category", category!);
  }

  Future <List<String>?> getLaundryCategoryList() async {
    List<String>? category = _prefs.getStringList("laundry_category");
    return category;
  }

  Future<void> cacheMakeUpCategoryList({required List<String>? category}) async {
    _prefs.setStringList("makeup_category", category!);
  }

  Future <List<String>?> getMakeUpCategoryList() async {
    List<String>? category = _prefs.getStringList("makeup_category");
    return category;
  }

  Future<void> cachePassword({required String? password}) async {
    _prefs.setString("password", password!);
  }

  Future<String?> getPassword() async {
    String? password = _prefs.getString("password");
    return password;
  }

  Future<bool> getLoginStatus() async {
    bool? userData = _prefs.getBool("isLoggedIn");
    return userData ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  Future<void> clearCache() async {
    _prefs.clear();
  }

  Future<bool?> getIsEnableNotificationStatus() async {
    bool? isEnableNotification = _prefs.getBool("isEnableNotification");
    return isEnableNotification;
  }

  Future<void> cacheIsEnableNotificationStatus({required bool isEnableNotification}) async {
    _prefs.setBool("isEnableNotification", isEnableNotification);
  }

Future<void> saveUserDetails({required AuthUserResponse authUserResponse}) async {
  _prefs.setString("saveUserDetails", jsonEncode(authUserResponse.toJson()));
}
Future<AuthUserResponse> fetchUserDetails() async {
  String? userData = _prefs.getString("saveUserDetails");
  return AuthUserResponse.fromJson(jsonDecode(userData!));
}

  Future<void> saveServiceProvidersList({required ServiceProviderResponseModel serviceProviderResponseModel}) async {
    _prefs.setString("service_provider", jsonEncode(serviceProviderResponseModel.toJson()));
  }
  Future<ServiceProviderResponseModel> fetchServiceProvidersList() async {
    final serviceProviders = _prefs.getString("service_provider");
    return ServiceProviderResponseModel.fromJson(jsonDecode(serviceProviders!));
  }

}