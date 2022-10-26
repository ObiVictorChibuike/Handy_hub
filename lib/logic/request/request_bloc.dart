import 'package:esolink/models/request_model/request_model.dart';
import 'package:rxdart/rxdart.dart';

class RequestBLoc {
  final _requests = BehaviorSubject<List<RequestsModel>>();
  final _requestID = BehaviorSubject<String>();

  Stream<List<RequestsModel>> get allRequest => _requests.stream;
  addAllRequest(List<RequestsModel>? e) => _requests.sink.add(e!);

  Stream<String> get requestID => _requestID.stream;
  addRequestID(String? e) => _requestID.sink.add(e!);

  void  dispose() async {
    await _requests.drain(0);
    _requests.close();
    await _requestID.drain(0);
    _requestID.close();
  }
}
