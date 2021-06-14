import 'dart:math';

import 'package:ecom/size_config.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(50),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/hot-trend-1.jpg'))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Casual v -neck'), Text('Rs102')],
              ),
              Container(
                    alignment: Alignment.center,
                height: getProportionateScreenHeight(34),
                width: getProportionateScreenWidth(38),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFf9a5ae),
                ),
                child: IconButton(icon: Icon(EvaIcons.heart,size: 20,color: Colors.white,), onPressed: (){}),
              ),
            ],
          )
        ],
      ),
    );
  }
}
