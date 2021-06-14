import 'package:ecom/components/nothingtoshow_container.dart';
import 'package:ecom/components/product_short_detail_card.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/models/OrderedProduct.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/models/Review.dart';
import 'package:ecom/screens/manage_addresses/manage_addresses_screen.dart';
import 'package:ecom/screens/my_orders/components/product_review_dialog.dart';
import 'package:ecom/screens/my_orders/my_orders_screen.dart';
import 'package:ecom/screens/product_details/product_details_screen.dart';
import 'package:ecom/screens/sign_in/sign_in_screen.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/data_streams/ordered_products_stream.dart';
import 'package:ecom/services/data_streams/orders_stream.dart';
import 'package:ecom/services/database/orders_database_helper.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../../../utils.dart';

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

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
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
                    "Your Profile",
                    style: headingStyle,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.75,
                    child: StreamBuilder<User>(
                        stream: AuthentificationService().userChanges,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final user = snapshot.data;
                            return buildOrderedProductsList(user);
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kSecondaryColor,
                              ),
                            );
                          } else {
                            return Center(
                              child: Icon(Icons.error),
                            );
                          }
                        }),
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

  Widget buildOrderedProductsList(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: SizeConfig.screenWidth,
            // height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: Text.rich(
                      TextSpan(
                        text: user.displayName == null
                            ? 'No Name'
                            : "${user.displayName}\n",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: user.email == null
                                ? "No Email"
                                : "${user.email}",
                            style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: FutureBuilder(
                      future: UserDatabaseHelper().displayPictureForCurrentUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: kSecondaryColor,
                            backgroundImage: NetworkImage(snapshot.data),
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
                        return CircleAvatar(
                          radius: 80,
                          backgroundColor: kSecondaryColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: SizeConfig.screenWidth,
            // height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 5,
                      child: Text('Edit Profile',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ))),
                  Flexible(
                    flex: 2,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              bool allowed = AuthentificationService().currentUserVerified;
              if (!allowed) {
                final reverify = await showConfirmationDialog(context,
                    "You haven't verified your email address. This action is only allowed for verified users.",
                    positiveResponse: "Resend verification email",
                    negativeResponse: "Go back");
                if (reverify) {
                  final future = AuthentificationService()
                      .sendVerificationEmailToCurrentUser();
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return FutureProgressDialog(
                        future,
                        message: Text("Resending verification email"),
                      );
                    },
                  );
                }
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageAddressesScreen(),
                ),
              );
            },
            child: Container(
              width: SizeConfig.screenWidth,
              // height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Text('Manage Addresses',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ))),
                    Flexible(
                      flex: 2,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              bool allowed = AuthentificationService().currentUserVerified;
              if (!allowed) {
                final reverify = await showConfirmationDialog(context,
                    "You haven't verified your email address. This action is only allowed for verified users.",
                    positiveResponse: "Resend verification email",
                    negativeResponse: "Go back");
                if (reverify) {
                  final future = AuthentificationService()
                      .sendVerificationEmailToCurrentUser();
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return FutureProgressDialog(
                        future,
                        message: Text("Resending verification email"),
                      );
                    },
                  );
                }
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyOrdersScreen(),
                ),
              );
            },
            child: Container(
              width: SizeConfig.screenWidth,
              // height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Text('My Orders',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ))),
                    Flexible(
                      flex: 2,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              final confirmation =
                  await showConfirmationDialog(context, "Confirm Sign out ?");
              if (confirmation) {
                AuthentificationService().signOut();
                _googleSignIn.disconnect();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SignInScreen();
                }));
              }
            },
            child: Container(
              width: SizeConfig.screenWidth,
              // height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Text('Log Out',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ))),
                    Flexible(
                      flex: 2,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
