import 'package:rxdart/rxdart.dart';
import 'login_validation.dart';

class LoginBloc with LoginValidation {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(emailValidation);
  addEmail(String? e) => _email.sink.add(e!);

  Stream<String> get password => _password.stream.transform(fieldValidation);
  addPassword(String? e) => _password.sink.add(e!);

  Stream<bool> get isSet => Rx.combineLatest2(email, password, (a, b) => true);

  get loginBody => {"username": _email.value, "password": _password.value};

  dispose() {
    _email.close();
    _password.close();
  }
}
