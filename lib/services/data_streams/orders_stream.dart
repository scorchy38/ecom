import 'package:ecom/models/Order.dart';
import 'package:ecom/services/data_streams/data_stream.dart';
import 'package:ecom/services/database/orders_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';

class OrdersStream extends DataStream<List<Order>> {
  @override
  void reload() {
    final ordersFuture = OrdersDatabaseHelper().getOrdersOfCurrentUser();
    ordersFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}
