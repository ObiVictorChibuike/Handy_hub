import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:esolink/logic/services_category/service_bloc.dart';
import 'package:esolink/logic/states/state_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

close() {
  locator.reset();
}

serviceLocator() {
  locator.registerLazySingleton(() => RegistrationBloc());
  locator.registerLazySingleton(() => CategoriesBloc());
  locator.registerLazySingleton(() => StateBloc());
}
