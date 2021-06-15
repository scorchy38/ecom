import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/database/product_database_helper.dart';

class OrdersDatabaseHelper {
  static const String ORDERS_COLLECTION_NAME = "orders";
  static const String PRODUCTS = "products";
  static const String TIMESTAMP = "timestamp";
  // static const String ORDERED_PRODUCTS_COLLECTION_NAME = "ordered_products";

  // static const String PHONE_KEY = 'phone';
  // static const String DP_KEY = "display_picture";
  // static const String FAV_PRODUCTS_KEY = "favourite_products";

  OrdersDatabaseHelper._privateConstructor();
  static OrdersDatabaseHelper _instance =
      OrdersDatabaseHelper._privateConstructor();
  factory OrdersDatabaseHelper() {
    return _instance;
  }
  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore {
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  //
  // Future<void> deleteCurrentUserData() async {
  //   final uid = AuthentificationService().currentUser.uid;
  //   final docRef = firestore.collection(USERS_COLLECTION_NAME).doc(uid);
  //   final cartCollectionRef = docRef.collection(CART_COLLECTION_NAME);
  //   final addressCollectionRef = docRef.collection(ADDRESSES_COLLECTION_NAME);
  //   final ordersCollectionRef =
  //       docRef.collection(ORDERED_PRODUCTS_COLLECTION_NAME);
  //
  //   final cartDocs = await cartCollectionRef.get();
  //   for (final cartDoc in cartDocs.docs) {
  //     await cartCollectionRef.doc(cartDoc.id).delete();
  //   }
  //   final addressesDocs = await addressCollectionRef.get();
  //   for (final addressDoc in addressesDocs.docs) {
  //     await addressCollectionRef.doc(addressDoc.id).delete();
  //   }
  //   final ordersDoc = await ordersCollectionRef.get();
  //   for (final orderDoc in ordersDoc.docs) {
  //     await ordersCollectionRef.doc(orderDoc.id).delete();
  //   }
  //
  //   await docRef.delete();
  // }

  Future<bool> addOrderForCurrentUser(Order order, String key) async {
    String uid = AuthentificationService().currentUser.uid;
    final addressesCollectionReference =
        firestore.collection(ORDERS_COLLECTION_NAME);
    await addressesCollectionReference.doc(key).set(order.toMap());
    return true;
  }

  Future<List<Order>> getOrdersOfCurrentUser() async {
    String uid = AuthentificationService().currentUser.uid;
    final addressesCollectionReference =
        firestore.collection(ORDERS_COLLECTION_NAME);
    List<Order> userOrders = [];
    await addressesCollectionReference.get().then((value) {
      for (var v in value.docs) {
        if (v.data()['userid'] == uid) userOrders.add(Order.fromMap(v.data()));
      }
    });
    return userOrders;
  }

  Future<List<Product>> getOrderItems(String orderId) async {
    String uid = AuthentificationService().currentUser.uid;
    print('data ${orderId}');
    final orderDocument =
        await firestore.collection(ORDERS_COLLECTION_NAME).doc(orderId).get();
    List<Product> orderedProducts = [];

    for (var v in orderDocument.data()['products_ordered']) {
      orderedProducts.add(await ProductDatabaseHelper().getProductWithID(v));
    }

    return orderedProducts;
  }

//
  // Future<bool> deleteAddressForCurrentUser(String id) async {
  //   String uid = AuthentificationService().currentUser.uid;
  //   final addressDocReference = firestore
  //       .collection(USERS_COLLECTION_NAME)
  //       .doc(uid)
  //       .collection(ADDRESSES_COLLECTION_NAME)
  //       .doc(id);
  //   await addressDocReference.delete();
  //   return true;
  // }

}
