import 'package:ecom/models/Category.dart';
import 'package:ecom/services/database/category_database_helper.dart';

import 'data_stream.dart';

class CategoriesStream extends DataStream<List<Category>> {
  @override
  void reload() {
    final categoriesFuture = CategoryDatabaseHelper().getCategories();
    categoriesFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}
