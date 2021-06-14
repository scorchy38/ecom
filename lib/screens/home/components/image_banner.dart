import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ImageBanner extends StatelessWidget {
  final String imageUrl;

  ImageBanner({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      width: getProportionateScreenWidth(double.infinity),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(imageUrl))),
    );
  }
}
