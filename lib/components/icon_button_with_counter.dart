import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/CartItem.dart';
import 'package:ecom/services/data_streams/cart_items_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../size_config.dart';

class IconButtonWithCounter extends StatefulWidget {
  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  const IconButtonWithCounter(
      {Key key,
      @required this.svgSrc,
      this.numOfItems = 0,
      @required this.press})
      : super(key: key);

  @override
  _IconButtonWithCounterState createState() => _IconButtonWithCounterState();
}

final CartItemsStream cartItemsStream = CartItemsStream();

class _IconButtonWithCounterState extends State<IconButtonWithCounter> {
  @override
  void initState() {
    super.initState();
    cartItemsStream.init();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior:
            Clip.none, // makes the stack clip over the overlapping widget
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            width: getProportionateScreenWidth(46),
            height: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor.withOpacity(0.2))),
            child: SvgPicture.asset(
              widget.svgSrc,
            ),
          ),
          if (widget.numOfItems > 0)
            StreamBuilder<List<CartItem>>(
              stream: cartItemsStream.stream,
              builder: (context, snapshot) {
                var items = snapshot.data;
                print('items ${items.length}');

                return Positioned(
                  right: 0,
                  top: -3,
                  child: Container(
                    width: getProportionateScreenWidth(20),
                    height: getProportionateScreenWidth(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF4848),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "items ${items.length}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          color: Colors.white,
                          height: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
