import 'package:rxdart/rxdart.dart';

class RegistrationBloc {
  final _userType = BehaviorSubject<String>();

  Stream<String> get userType => _userType.stream;
  addUserType(String? e) => _userType.sink.add(e!);

  dispose() {
    _userType.close();
  }
}
