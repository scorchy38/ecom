import 'package:flutter/material.dart';

import 'components/body.dart';

class CheckoutScreen extends StatelessWidget {
  List<String> productIds;
  List<int> quantities;
  List<num> prices;
  num amount;
  CheckoutScreen({this.quantities, this.prices, this.productIds, this.amount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(
          prices: prices,
          productIds: productIds,
          quantities: quantities,
          amount: amount),
    );
  }
}
