import 'package:ecom/models/Product.dart';

import 'package:flutter/material.dart';

import 'components/body.dart';

class CategoryProductsScreen extends StatelessWidget {
  final ProductType productType;
  final Widget banner;

  const CategoryProductsScreen(
      {Key key, @required this.productType, @required this.banner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(productType: productType, banner: banner),
    );
  }
}
