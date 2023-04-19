import 'package:location/location.dart';

class GetLocation {
  static GetLocation? _instance;
  static GetLocation? get instance {
    _instance ??= GetLocation._init();
    return _instance;
  }
  GetLocation._init();
  Future<LocationData> get checkLocation => checkLocationPermission();

  Future<LocationData> checkLocationPermission() async{
    LocationData currentPosition; bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled) {
        return Future.error("Location Service Disabled");
      }
    }
    permissionGranted = await Location().hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await Location().requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error("Location services permission not granted");
      }
    }
    currentPosition = await Location().getLocation();
    Location().onLocationChanged.listen((LocationData currentLocation) {
      Location().enableBackgroundMode(enable: true);
      Location().changeSettings(accuracy: LocationAccuracy.high);
      currentPosition = currentLocation;
    });
    return currentPosition;
  }

}