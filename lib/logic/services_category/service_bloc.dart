import 'package:esolink/models/services_category/categories.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  final _categories = BehaviorSubject<List<CategoriesModel>>();

  Stream<List<CategoriesModel>> get allCategories => _categories.stream;
  addAllCategories(List<CategoriesModel>? e) => _categories.sink.add(e!);

  dispose() {
    _categories.close();
  }
}
