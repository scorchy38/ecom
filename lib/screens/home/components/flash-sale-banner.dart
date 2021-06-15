import 'dart:math';

import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';

class FlashSaleBanner extends StatelessWidget {
  // const FlashSaleBanner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getProportionateScreenHeight(5),
        bottom: getProportionateScreenHeight(5),
        right: getProportionateScreenHeight(8),
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/hot-trend-1.jpg'))),
      // child: Image(image:  AssetImage('assets/images/hot-trend-1.jpg')),
    );
  }
}

class FinalFlashSaleBanner extends StatelessWidget {
  String oriprice;
  String discPrice;
  String discount;
  FinalFlashSaleBanner({
    this.oriprice,
    this.discPrice,
    this.discount,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Colors.white,
          margin: EdgeInsets.all(getProportionateScreenHeight(1)),
          height: height * 0.28,
          width: width * 0.3,
        ),
        Transform.rotate(
          angle: 0.6,
          child: Container(
            margin: EdgeInsets.only(top: height * 0.0345, right: width * 0.175),
            decoration: BoxDecoration(
              color: Colors.orange[200],
            ),
            height: height * 0.03,
            width: width * 0.1,
            alignment: Alignment.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: height * 0.28,
          width: width * 0.285,
          child: Column(children: [
            Container(
              height: height * 0.22,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'assets/images/hot-trend-${Random().nextInt(3) + 1}.jpg'))),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "₹$discPrice",
                  style: TextStyle(
                    color: Colors.redAccent[700],
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  "₹$oriprice",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.02, right: width * 0.2),
          decoration: BoxDecoration(
            color: Colors.orange[200],
          ),
          height: height * 0.03,
          width: width * 0.1,
          alignment: Alignment.center,
          child: Text('-$discount%',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}
