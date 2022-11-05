import 'package:esolink/models/request_model/request_model.dart';
import 'package:rxdart/rxdart.dart';

class RequestBLoc {
  final _requests = BehaviorSubject<List<RequestsModel>>();
  final _requestID = BehaviorSubject<String>();

  Stream<List<RequestsModel>> get allRequest => _requests.stream;
  addAllRequest(List<RequestsModel>? e) => _requests.sink.add(e!);

  Stream<String> get requestID => _requestID.stream;
  addRequestID(String? e) => _requestID.sink.add(e!);

  void dispose() async {
    await _requests.drain([0]);
    _requests.close();
    await _requestID.drain(0);
    _requestID.close();
  }
}

class MakeRequestBloc {
  final BehaviorSubject<String> _fullName = BehaviorSubject<String>();
  final BehaviorSubject<String> _email = BehaviorSubject<String>();
  final BehaviorSubject<String> _phoneNumber = BehaviorSubject<String>();
  final BehaviorSubject<int> _categoryID = BehaviorSubject<int>();
  final BehaviorSubject<String> _location = BehaviorSubject<String>();
  final BehaviorSubject<int> _serviceProviderID = BehaviorSubject<int>();

  Stream<String> get fullName => _fullName.stream;
  addFullName(String? fullName) => _fullName.sink.add(fullName!);

  Stream<String> get email => _email.stream;
  addEmail(String? e) => _email.sink.add(e!);

  Stream<String> get phoneNumber => _phoneNumber.stream;
  addPhone(String? e) => _phoneNumber.sink.add(e!);

  Stream<String> get location => _location.stream;
  addLocale(String? e) => _location.sink.add(e!);

  Stream<int> get categoryID => _categoryID.stream;
  addCategoryID(int? e) => _categoryID.sink.add(e!);

  Stream<int> get seriviceID => _serviceProviderID.stream;
  addServiceID(int? e) => _serviceProviderID.sink.add(e!);

  get body => {
        "fullName": _fullName.value,
        "email": _email.value,
        "phoneNumber": _phoneNumber.value,
        "categoryId": _categoryID.value,
        "location": _location.value,
        "serviceProviderId": _serviceProviderID.value
      };
}
