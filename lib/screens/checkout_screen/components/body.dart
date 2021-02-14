import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/components/default_button.dart';
import 'package:ecom/components/nothingtoshow_container.dart';
import 'package:ecom/models/Order.dart';
import 'package:ecom/screens/edit_address/edit_address_screen.dart';
import 'package:ecom/screens/home/components/section_tile.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/data_streams/addresses_stream.dart';
import 'package:ecom/services/database/orders_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'address_box.dart';
import 'address_short_details_card.dart';

class Body extends StatefulWidget {
  List<String> productIds;
  List<int> quantities;
  List<num> prices;
  num amount;
  Body({this.quantities, this.prices, this.productIds, this.amount});
  @override
  _BodyState createState() => _BodyState();
}

int indexSelected = 0;
String selectedAddress = '';

class _BodyState extends State<Body> {
  final AddressesStream addressesStream = AddressesStream();
  String deliverySelected;
  @override
  void initState() {
    super.initState();
    deliverySelected = 'Standard';
    indexSelected = 0;
    getDeliveryDate();
    addressesStream.init();
  }

  DateTime deliveryDate;
  getDeliveryDate() async {
    DateTime currentDate = await DateTime.now();

    switch (currentDate.weekday) {
      case 1:
        deliveryDate = await currentDate.add(Duration(days: 2));
        setState(() {});
        break;
      case 2:
        deliveryDate = await currentDate.add(Duration(days: 1));
        setState(() {});
        break;
      case 3:
        deliveryDate = await currentDate.add(Duration(days: 3));
        setState(() {});
        break;
      case 4:
        deliveryDate = await currentDate.add(Duration(days: 2));
        setState(() {});
        break;
      case 5:
        deliveryDate = await currentDate.add(Duration(days: 1));
        setState(() {});
        break;
      case 6:
        deliveryDate = await currentDate.add(Duration(days: 4));
        setState(() {});
        break;
      case 7:
        deliveryDate = await currentDate.add(Duration(days: 3));
        setState(() {});
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    addressesStream.dispose();
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
                    "Checkout",
                    style: headingStyle,
                  ),

                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose an address',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAddressScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Add new',
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.7),
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Double tap to see address details'),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),

                  // DefaultButton(
                  //   text: "Add New Address",
                  //   press: () async {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => EditAddressScreen(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: getProportionateScreenHeight(30)),

                  StreamBuilder<List<String>>(
                    stream: addressesStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final addresses = snapshot.data;
                        if (addresses.length == 0) {
                          return Center(
                            child: NothingToShowContainer(
                              iconPath: "assets/icons/add_location.svg",
                              secondaryMessage: "Add your first Address",
                            ),
                          );
                        }
                        return SizedBox(
                          height: getProportionateScreenHeight(
                              addresses.length * 150.0),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return buildAddressItemCard(
                                    addresses[index], index);
                              }),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
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
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Options',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            deliverySelected = 'Standard';
                            setState(() {});
                          },
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: deliverySelected == 'Standard'
                                    ? kPrimaryColor
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                          ),
                        ),
                        Text(
                          '  Standard Delivery',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                          'Your Order will be delivered on ${deliveryDate.day}-${deliveryDate.month}-${deliveryDate.year}'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            deliverySelected = 'Express';
                            setState(() {});
                          },
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: deliverySelected == 'Express'
                                    ? kPrimaryColor
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                          ),
                        ),
                        Text(
                          '  Express Delivery',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                          'Your Order will be delivered on ${DateTime.now().add(Duration(days: 1)).day}-${DateTime.now().add(Duration(days: 1)).month}-${DateTime.now().add(Duration(days: 1)).year}'),
                    ],
                  ),

                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bill details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Item Total: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'Rs. ${widget.amount}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Tax and Delivery charges: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: deliverySelected == 'Standard'
                                  ? 'Rs. ${(widget.amount * 0.2)}'
                                  : 'Rs. ${(widget.amount * 0.2) + 100}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Amount: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: deliverySelected == 'Standard'
                                  ? 'Rs. ${widget.amount + (widget.amount * 0.2)}'
                                  : 'Rs. ${widget.amount + (widget.amount * 0.2) + 100}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DefaultButton(
                    text: 'Place Order',
                    press: () async {
                      Timestamp timestamp = await Timestamp.now();
                      String snackbarmMessage = '';

                      try {
                        String random = await randomAlpha(10);
                        var userId = AuthentificationService().currentUser.uid;
                        // String address = await UserDatabaseHelper()
                        //     .getAddressFromId(selectedAddress)
                        //     .toString();

                        Order o = new Order(random,
                            timestamp: timestamp,
                            orderType: OrderType.COD,
                            productsOrdered: widget.productIds,
                            deliveryType: deliverySelected,
                            userid: userId,
                            status: 'Pending',
                            deliveryTimestamp:
                                Timestamp.fromMillisecondsSinceEpoch(
                                    deliveryDate.millisecondsSinceEpoch),
                            prices: widget.prices,
                            quantities: widget.quantities,
                            address: selectedAddress,
                            orderid: random,
                            amount: widget.amount);
                        var addedProductsToMyProducts =
                            await OrdersDatabaseHelper()
                                .addOrderForCurrentUser(o, random);
                        if (addedProductsToMyProducts) {
                          snackbarmMessage = "Products ordered Successfully";
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomeScreen()));
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
                            content: Text(
                                snackbarmMessage ?? "Something went wrong"),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    addressesStream.reload();
    return Future<void>.value();
  }

  Widget buildAddressItemCard(String addressId, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: AddressShortDetailsCard(
        addressId: addressId,
        showShadow: indexSelected == index ? true : false,
        onDoubleTap: () async {
          await addressItemTapCallback(addressId);
        },
        onTap: () {
          indexSelected = index;
          selectedAddress = addressId;
          setState(() {});
        },
      ),
    );
  }

  Future<void> addressItemTapCallback(String addressId) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.transparent,
          title: AddressBox(
            addressId: addressId,
          ),
          titlePadding: EdgeInsets.zero,
        );
      },
    );
    await refreshPage();
  }
}
