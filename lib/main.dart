import 'package:esolink/service_locator.dart';
import 'package:esolink/views/screens/dashboard/dashboard.dart';
import 'package:esolink/views/screens/splash_screens/splash_screens.dart';
import 'package:esolink/views/themes/light_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic/api_services/local/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<LocalCachedData>(await LocalCachedData.create());
  final hasOnBoarded = await LocalCachedData.instance.getHasOnBoardedStatus();
  runApp(MyApp(hasOnBoarded: hasOnBoarded,));
  serviceLocator();
}

class MyApp extends StatelessWidget {
  final bool? hasOnBoarded;
  const MyApp({Key? key, this.hasOnBoarded}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Handyhub',
          theme: lightTheme,
          home: hasOnBoarded == true ? const Dashboard() : const SplashScreen()),
    );
  }
}
