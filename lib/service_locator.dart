import 'package:esolink/logic/login/login_bloc.dart';
import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/logic/request/request_bloc.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:esolink/logic/store/stores_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

close() {
  locator.reset();
}

serviceLocator() {
  locator.registerLazySingleton(() => RegistrationBloc());
  locator.registerLazySingleton(() => CategoriesBloc());
  locator.registerLazySingleton(() => StateBloc());
  locator.registerLazySingleton(() => LoginBloc());
  locator.registerLazySingleton(() => RequestBLoc());
  locator.registerLazySingleton(() => MakeRequestBloc());
  locator.registerLazySingleton(() => StoresBLoc());
}
