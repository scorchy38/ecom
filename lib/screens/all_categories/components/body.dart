import 'package:ecom/components/nothingtoshow_container.dart';
import 'package:ecom/components/product_short_detail_card.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/Category.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/models/OrderedProduct.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/models/Review.dart';
import 'package:ecom/screens/category_products/category_products_screen.dart';
import 'package:ecom/screens/my_orders/components/product_review_dialog.dart';
import 'package:ecom/screens/product_details/product_details_screen.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/data_streams/all_products_stream.dart';
import 'package:ecom/services/data_streams/categories_stream.dart';
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
  @override
  void initState() {
    super.initState();
    categoriesStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    categoriesStream.dispose();
  }

  CategoriesStream categoriesStream = CategoriesStream();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "All Categories",
                  style: headingStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                    height: SizeConfig.screenHeight * 0.75,
                    child: StreamBuilder<List<Category>>(
                      stream: categoriesStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final categories = snapshot.data;
                          if (categories.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                iconPath: "assets/icons/empty_bag.svg",
                                secondaryMessage:
                                    "Order something to show here",
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              // print('order id ${orders[index].orderid}');
                              return InkWell(
                                onTap: categories[index].status == 'active'
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryProductsScreen(
                                              productType: categories[index]
                                                          .catName ==
                                                      'Fashion'
                                                  ? ProductType.Fashion
                                                  : categories[index].catName ==
                                                          'Handicrafts'
                                                      ? ProductType.Handicrafts
                                                      : categories[index]
                                                                  .catName ==
                                                              'Jewellery'
                                                          ? ProductType
                                                              .Jewellery
                                                          : categories[index]
                                                                      .catName ==
                                                                  'Home Decor'
                                                              ? ProductType
                                                                  .HomeDecor
                                                              : categories[index]
                                                                          .catName ==
                                                                      'Electronics'
                                                                  ? ProductType
                                                                      .Electronics
                                                                  : ProductType
                                                                      .Others,
                                              banner: Container(
                                                width: SizeConfig.screenWidth,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: kPrimaryColor
                                                          .withOpacity(0.15),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Image.network(
                                                    categories[index].bannerUrl,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    : () {},
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: SizeConfig.screenWidth,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.15),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                            categories[index].bannerUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    categories[index].status == 'inactive'
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: SizeConfig.screenWidth,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Coming Soon',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white),
                                              )),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    categoriesStream.reload();
    return Future<void>.value();
  }
}
