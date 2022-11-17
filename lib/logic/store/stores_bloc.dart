import 'package:esolink/models/stores_model/store_categories.dart';
import 'package:esolink/models/stores_model/stores_model.dart';
import 'package:rxdart/rxdart.dart';

class StoresBLoc {
  final BehaviorSubject<List<Stores>> _stores = BehaviorSubject<List<Stores>>();

  Stream<List<Stores>> get stores => _stores.stream;
  addStores(List<Stores>? e) => _stores.sink.add(e!);

  final BehaviorSubject<List<StoresCategory>> _storesCategory =
      BehaviorSubject<List<StoresCategory>>();

  Stream<List<StoresCategory>> get storesCategories => _storesCategory.stream;
  addStoresCategories(List<StoresCategory>? e) => _storesCategory.sink.add(e!);

  dispose() async {
    await _stores.drain(0);
    _stores.close();
    await _storesCategory.drain(0);
    _storesCategory.close();
  }
}
