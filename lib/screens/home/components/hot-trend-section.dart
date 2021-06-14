import 'dart:math';

import 'package:ecom/constants.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HotTrendItemSection extends StatefulWidget {
  // const HotTrendItemSection({ Key? key }) : super(key: key);

  @override
  _HotTrendItemSectionState createState() => _HotTrendItemSectionState();
}

class _HotTrendItemSectionState extends State<HotTrendItemSection> {

  Widget staggedGriItem() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.009,
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          // gradient: new LinearGradient(
          //         end: const Alignment(0.0, -5),
          //         begin: const Alignment(0.0, 0.6),
          //         colors: <Color>[
          //           const Color(0x8A000000),
          //           Colors.black12.withOpacity(0.0)
          //         ],
          //       ),

          boxShadow: [
            BoxShadow(
              color: Colors.grey[600],
              blurRadius: 0.07,
              spreadRadius: 0.07,
            )
          ],
          // border: Border.all(
          //   color: Colors.grey[200],
          // ),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/hot-trend-${Random().nextInt(3) + 1}.jpg',
              ))),
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.01,
        ),
        width: MediaQuery.of(context).size.width * 0.14,
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Text(
          'MULTI COLORED',
          textAlign: TextAlign.center,
          style: titleTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#Hottest Trends🔥'),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: 8,
                            itemBuilder: (BuildContext context, int i) {
                              return staggedGriItem();
                            },
                            mainAxisSpacing: getProportionateScreenHeight(10),
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.count(1, index.isOdd ? 1 : 1.5);
                            }),
          ],
        ),
    );
  }
}