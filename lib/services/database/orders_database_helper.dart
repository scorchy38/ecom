import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/services/authentification/authentification_service.dart';

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

  Future<bool> addOrderForCurrentUser(Order order) async {
    String uid = AuthentificationService().currentUser.uid;
    final addressesCollectionReference =
        firestore.collection(ORDERS_COLLECTION_NAME);
    await addressesCollectionReference.add(order.toMap());
    return true;
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
