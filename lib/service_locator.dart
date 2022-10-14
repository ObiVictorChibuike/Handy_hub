import 'package:esolink/logic/registration/registration_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

close() {
  locator.reset();
}

serviceLocator() {
  locator.registerLazySingleton(() => RegistrationBloc());
}
