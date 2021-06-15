import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/Category.dart';
import 'package:ecom/services/authentification/authentification_service.dart';

class CategoryDatabaseHelper {
  static const String CATEGORY_COLLECTION_NAME = "categories";

  // static const String ORDERED_PRODUCTS_COLLECTION_NAME = "ordered_products";

  // static const String PHONE_KEY = 'phone';
  // static const String DP_KEY = "display_picture";
  // static const String FAV_PRODUCTS_KEY = "favourite_products";

  CategoryDatabaseHelper._privateConstructor();
  static CategoryDatabaseHelper _instance =
      CategoryDatabaseHelper._privateConstructor();
  factory CategoryDatabaseHelper() {
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

  Future<List<Category>> getCategories() async {
    final categoryCollectionReference =
        firestore.collection(CATEGORY_COLLECTION_NAME);
    List<Category> categories = [];
    await categoryCollectionReference.get().then((value) {
      for (var v in value.docs) {
        categories.add(Category.fromMap(v.data()));
      }
    });
    return categories;
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
