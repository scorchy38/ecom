import 'package:ecom/screens/home/components/product.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flash-sale-banner.dart';

class FlashSale extends StatefulWidget {
  // const FlashSale({ Key? key }) : super(key: key);

  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#Special Offer'),
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget> [
                  
                  FlashSaleBanner(),
                  FlashSaleBanner(),
                  FlashSaleBanner(),
                ],
              ),
            )
          ],
        ),
    );
  }
}