import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';

class FlashSaleBanner extends StatelessWidget {
  // const FlashSaleBanner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getProportionateScreenHeight(3)),
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/hot-trend-1.jpg'))),
      // child: Image(image:  AssetImage('assets/images/hot-trend-1.jpg')),
    );
  }
}
