import 'package:esolink/models/services_category/categories.dart';
import 'package:esolink/models/states/states_model.dart';
import 'package:rxdart/rxdart.dart';

class StateBloc {
  final _states = BehaviorSubject<List<StateModel>>();

  Stream<List<StateModel>> get allStates => _states.stream;
  addAllStates(List<StateModel>? e) => _states.sink.add(e!);

  dispose() {
    _states.close();
  }
}
