import 'package:ecom/components/nothingtoshow_container.dart';
import 'package:ecom/components/product_short_detail_card.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/models/OrderedProduct.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/models/Review.dart';
import 'package:ecom/screens/my_orders/components/product_review_dialog.dart';
import 'package:ecom/screens/product_details/product_details_screen.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/data_streams/ordered_products_stream.dart';
import 'package:ecom/services/data_streams/orders_stream.dart';
import 'package:ecom/services/database/orders_database_helper.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final OrdersStream ordersStream = OrdersStream();

  @override
  void initState() {
    super.initState();
    ordersStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    ordersStream.dispose();
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
                    "Your Orders",
                    style: headingStyle,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.75,
                    child: buildOrderedProductsList(),
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
    ordersStream.reload();
    return Future<void>.value();
  }

  Widget buildOrderedProductsList() {
    return StreamBuilder<List<Order>>(
      stream: ordersStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final orders = snapshot.data;
          if (orders.length == 0) {
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/empty_bag.svg",
                secondaryMessage: "Order something to show here",
              ),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              // print('order id ${orders[index].orderid}');
              return FutureBuilder<List<Product>>(
                future:
                    OrdersDatabaseHelper().getOrderItems(orders[index].orderid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final orderedProduct = snapshot.data;
                    return buildOrderedProductItem(
                        orderedProduct, orders[index]);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kSecondaryColor,
                    ));
                  } else if (snapshot.hasError) {
                    final error = snapshot.error.toString();
                    Logger().e(error);
                  }
                  return Icon(
                    Icons.error,
                    size: 60,
                    color: kTextColor,
                  );
                },
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kSecondaryColor,
            ),
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

  Widget buildOrderedProductItem(List<Product> orderedProducts, Order order) {
    List<Widget> products = [];
    for (int i = 0; i < orderedProducts.length; i++) {
      products.add(ProductShortDetailCard(
        productId: orderedProducts[i].id,
        quantity: order.quantities[i].toString(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productId: orderedProducts[i].id,
              ),
            ),
          ).then((_) async {
            await refreshPage();
          });
        },
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: kTextColor.withOpacity(0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text.rich(
              TextSpan(
                text: "Ordered on:  ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text:
                        '${order.timestamp.toDate().day}-${order.timestamp.toDate().month}-${order.timestamp.toDate().year}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: kTextColor.withOpacity(0.15),
                ),
              ),
            ),
            child: Column(
              children: products,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: FlatButton(
              color: kPrimaryColor,
              child: Text(
                "Order Total - ${order.amount}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
