import 'package:ecom/components/rounded_icon_button.dart';
import 'package:ecom/components/search_field.dart';
import 'package:ecom/services/data_streams/cart_items_stream.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../components/icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  final Function onSearchSubmitted;
  final Function onCartButtonPressed;
  final Function onWishlistButtonPressed;
  final int cartLen;
  final CartItemsStream cartItemsStream;
  HomeHeader(
      {Key key,
      @required this.onSearchSubmitted,
      @required this.onCartButtonPressed,
      @required this.cartItemsStream,
      @required this.onWishlistButtonPressed,
      @required this.cartLen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // RoundedIconButton(
        //     iconData: Icons.menu,
        //     press: () {
        //       Scaffold.of(context).openDrawer();
        //     }),
        // Expanded(
        //   child: SearchField(
        //     onSubmit: onSearchSubmitted,
        //   ),
        // ),

        // SizedBox(width: 5),
        IconButton(icon: Icon(EvaIcons.search), onPressed: () {}),
        SizedBox(width: getProportionateScreenWidth(50)),
        Text(
          'MarketMela',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
        ),
        SizedBox(width: getProportionateScreenWidth(50)),
        IconButton(icon: Icon(EvaIcons.headphones), onPressed: () {}),
        IconButton(icon: Icon(EvaIcons.heartOutline), onPressed: () {})
        // IconButtonWithCounter(
        //   svgSrc: "assets/icons/favourite.svg",
        //   press: onWishlistButtonPressed,
        // ),
      ],
    );
  }
}
