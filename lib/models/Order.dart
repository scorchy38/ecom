import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/Address.dart';
import 'package:ecom/models/Model.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum OrderType { COD, Online }

class Order extends Model {
  static const String TIMESTAMP_KEY = "timestamp";
  static const String USER_ID_KEY = "userid";
  static const String AMOUNT_KEY = "amount";
  static const String PRODUCTS_ORDERED_KEY = "products_ordered";
  static const String ORDER_TYPE_KEY = "order_type";
  static const String ADDRESS_KEY = "address";
  static const String QUANTITIES_KEY = "quantities";
  static const String PRICES_KEY = "prices";
  static const String STATUS_KEY = "status";

  List<String> productsOrdered;
  List<int> quantities;
  List<int> prices;
  Timestamp timestamp;
  String userid;
  String status;
  String address;
  int amount;
  OrderType orderType;

  Order(String id,
      {this.timestamp,
      this.amount,
      this.orderType,
      this.productsOrdered,
      this.userid,
      this.status,
      this.address,
      this.prices,
      this.quantities})
      : super(id);

  Future<Timestamp> calculateDeliveryTime() async {
    Duration difference =
        await Timestamp.now().toDate().difference(timestamp.toDate());
    Timestamp deliveryTime = Timestamp.fromDate(
        DateTime.fromMillisecondsSinceEpoch(difference.inMilliseconds));
    return deliveryTime;
  }

  factory Order.fromMap(Map<String, dynamic> map, {String id}) {
    return Order(
      id,
      userid: map[USER_ID_KEY],
      amount: map[AMOUNT_KEY],
      timestamp: map[TIMESTAMP_KEY],
      status: map[STATUS_KEY],
      address: map[ADDRESS_KEY],
      quantities: map[QUANTITIES_KEY].cast<int>(),
      prices: map[PRICES_KEY].cast<int>(),
      orderType: EnumToString.fromString(OrderType.values, map[ORDER_TYPE_KEY]),
      productsOrdered: map[PRODUCTS_ORDERED_KEY].cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      TIMESTAMP_KEY: timestamp,
      USER_ID_KEY: userid,
      AMOUNT_KEY: amount,
      ORDER_TYPE_KEY: EnumToString.convertToString(orderType),
      STATUS_KEY: status,
      ADDRESS_KEY: address,
      QUANTITIES_KEY: quantities,
      PRICES_KEY: prices,
      PRODUCTS_ORDERED_KEY: productsOrdered,
    };

    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};

    if (userid != null) map[USER_ID_KEY] = userid;
    if (amount != null) map[AMOUNT_KEY] = amount;
    if (timestamp != null) map[TIMESTAMP_KEY] = timestamp;
    if (status != null) map[STATUS_KEY] = status;
    if (address != null) map[ADDRESS_KEY] = address;
    if (quantities != null) map[QUANTITIES_KEY] = quantities;
    if (prices != null) map[PRICES_KEY] = prices;
    if (productsOrdered != null) map[PRODUCTS_ORDERED_KEY] = productsOrdered;
    if (orderType != null)
      map[ORDER_TYPE_KEY] = EnumToString.convertToString(orderType);

    return map;
  }
}
