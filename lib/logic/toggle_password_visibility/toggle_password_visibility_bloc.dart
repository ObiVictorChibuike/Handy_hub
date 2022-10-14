import 'package:rxdart/rxdart.dart';

class TogglePasswordVisibilityBloc {
  final _showPassword = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _passwordShown = BehaviorSubject<bool>();

  Stream<bool> get showPassword => _showPassword.stream;
  Stream<bool> get passwordShown => _passwordShown.stream;
  setPasswordShown(bool? e) => _passwordShown.sink.add(e!);

  toggleShowPassword() {
    _showPassword.add(!_showPassword.value);
    _passwordShown.add(!_passwordShown.value);
  }
 

  TogglePasswordVisibilityBloc() {
    _showPassword.add(true);
    _passwordShown.add(true);
  }
}
