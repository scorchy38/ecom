import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/components/default_button.dart';
import 'package:ecom/components/nothingtoshow_container.dart';
import 'package:ecom/components/product_short_detail_card.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/CartItem.dart';
import 'package:ecom/models/OrderedProduct.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/screens/cart/components/checkout_card.dart';
import 'package:ecom/screens/product_details/product_details_screen.dart';
import 'package:ecom/services/data_streams/cart_items_stream.dart';
import 'package:ecom/services/data_streams/favourite_products_stream.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';

import '../../../utils.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FavouriteProductsStream wishlistItemsStream = FavouriteProductsStream();
  PersistentBottomSheetController bottomSheetHandler;
  @override
  void initState() {
    super.initState();
    wishlistItemsStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    wishlistItemsStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(screenPadding)),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    "Your Wishlist",
                    style: headingStyle,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.75,
                    child: Center(
                      child: buildWishlistItemsList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    wishlistItemsStream.reload();
    return Future<void>.value();
  }

  Widget buildWishlistItemsList() {
    return StreamBuilder<List<String>>(
      stream: wishlistItemsStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> cartItemsId = snapshot.data;
          if (cartItemsId.length == 0) {
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/empty_cart.svg",
                secondaryMessage: "Your wishlist is empty",
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  physics: BouncingScrollPhysics(),
                  itemCount: cartItemsId.length,
                  itemBuilder: (context, index) {
                    if (index >= cartItemsId.length) {
                      return SizedBox(height: getProportionateScreenHeight(80));
                    }
                    return buildCartItemDismissible(
                        context, cartItemsId[index], index);
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildCartItemDismissible(
      BuildContext context, String cartItemId, int index) {
    return Dismissible(
      key: Key(cartItemId),
      direction: DismissDirection.startToEnd,
      dismissThresholds: {
        DismissDirection.startToEnd: 0.65,
      },
      background: buildDismissibleBackground(),
      child: buildCartItem(cartItemId, index),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final confirmation = await showConfirmationDialog(
            context,
            "Remove Product from Wishlist?",
          );
          if (confirmation) {
            if (direction == DismissDirection.startToEnd) {
              bool result = false;
              String snackbarMessage;
              try {
                result = await UserDatabaseHelper()
                    .switchProductFavouriteStatus(cartItemId, false);
                if (result == true) {
                  snackbarMessage =
                      "Product removed from wishlist successfully";
                  await refreshPage();
                } else {
                  throw "Coulnd't remove product from wishlist due to unknown reason";
                }
              } on FirebaseException catch (e) {
                Logger().w("Firebase Exception: $e");
                snackbarMessage = "Something went wrong";
              } catch (e) {
                Logger().w("Unknown Exception: $e");
                snackbarMessage = "Something went wrong";
              } finally {
                Logger().i(snackbarMessage);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(snackbarMessage),
                  ),
                );
              }

              return result;
            }
          }
        }
        return false;
      },
      onDismissed: (direction) {},
    );
  }

  Widget buildCartItem(String cartItemId, int index) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 4,
        top: 4,
        right: 4,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: kTextColor.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder<Product>(
        future: ProductDatabaseHelper().getProductWithID(cartItemId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ProductShortDetailCard(
                    productId: product.id,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          } else {
            return Center(
              child: Icon(
                Icons.error,
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildDismissibleBackground() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkoutButtonCallback() async {
    shutBottomSheet();
    final confirmation = await showConfirmationDialog(
      context,
      "Do you want to proceed for Mock Ordering of Products?",
    );
    if (confirmation == false) {
      return;
    }
    final orderFuture = UserDatabaseHelper().emptyCart();
    orderFuture.then((orderedProductsUid) async {
      if (orderedProductsUid != null) {
        print(orderedProductsUid);
        final dateTime = DateTime.now();
        final formatedDateTime =
            "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        List<OrderedProduct> orderedProducts = orderedProductsUid
            .map((e) => OrderedProduct(null,
                productUid: e, orderDate: formatedDateTime))
            .toList();
        bool addedProductsToMyProducts = false;
        String snackbarmMessage;
        try {
          addedProductsToMyProducts =
              await UserDatabaseHelper().addToMyOrders(orderedProducts);
          if (addedProductsToMyProducts) {
            snackbarmMessage = "Products ordered Successfully";
          } else {
            throw "Could not order products due to unknown issue";
          }
        } on FirebaseException catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } finally {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarmMessage ?? "Something went wrong"),
            ),
          );
        }
      } else {
        throw "Something went wrong while clearing cart";
      }
      await showDialog(
        context: context,
        builder: (context) {
          return FutureProgressDialog(
            orderFuture,
            message: Text("Placing the Order"),
          );
        },
      );
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    });
    await showDialog(
      context: context,
      builder: (context) {
        return FutureProgressDialog(
          orderFuture,
          message: Text("Placing the Order"),
        );
      },
    );
    await refreshPage();
  }

  void shutBottomSheet() {
    if (bottomSheetHandler != null) {
      bottomSheetHandler.close();
    }
  }

  Future<void> arrowUpCallback(String cartItemId) async {
    shutBottomSheet();
    final future = UserDatabaseHelper().increaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return FutureProgressDialog(
          future,
          message: Text("Please wait"),
        );
      },
    );
  }

  Future<void> arrowDownCallback(String cartItemId) async {
    shutBottomSheet();
    final future = UserDatabaseHelper().decreaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return FutureProgressDialog(
          future,
          message: Text("Please wait"),
        );
      },
    );
  }
}
