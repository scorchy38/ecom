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
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/hot-trend-${Random().nextInt(3) + 1}.jpg',
              )),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.05,
                0.2,
                0.8
              ],
              //     image: DecorationImage(
              //         fit: BoxFit.fill,
              //         image: AssetImage(
              //           'assets/images/hot-trend-${Random().nextInt(3) + 1}.jpg',
              //         ))),
              colors: [
                Colors.transparent,
                // Colors.grey
                //     .withOpacity(
                //         0.01),
                Colors.transparent,
                Colors.black26,
                Colors.black,
              ])),
      // decoration: BoxDecoration(

      //     // gradient: new LinearGradient(
      //     //         end: const Alignment(0.0, -5),
      //     //         begin: const Alignment(0.0, 0.6),
      //     //         colors: <Color>[
      //     //           const Color(0x8A000000),
      //     //           Colors.black12.withOpacity(0.0)
      //     //         ],
      //     //       ),

      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey[600],
      //         blurRadius: 0.07,
      //         spreadRadius: 0.07,
      //       )
      //     ],
      //     // border: Border.all(
      //     //   color: Colors.grey[200],
      //     // ),

      child: Container(
        height: getProportionateScreenWidth(40),
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: getProportionateScreenWidth(5)
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
         gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.05,
                0.2,
                0.8
              ],
              
               //     image: DecorationImage(
      //         fit: BoxFit.fill,
      //         image: AssetImage(
      //           'assets/images/hot-trend-${Random().nextInt(3) + 1}.jpg',
      //         ))),
              colors: [
                Colors.transparent,
                // Colors.grey
                //     .withOpacity(
                //         0.01),
                Colors.transparent,
                Colors.black26,
                Colors.black,
              ])
        ),
        child: Column(
          children: [
            Text(
              'MULTI COLORED',
              textAlign: TextAlign.center,
              style: titleTextStyle,
            ),
            Text(
              'MANY VARIANT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                color: Colors.white
              ),
            ),
          ],
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
