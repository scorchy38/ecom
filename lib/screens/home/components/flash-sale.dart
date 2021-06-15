import 'package:ecom/screens/home/components/product.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

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
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#Special Offer 💕 \n ⏰',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
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

class FinalFlashSale extends StatefulWidget {
  @override
  _FinalFlashSaleState createState() => _FinalFlashSaleState();
}

class _FinalFlashSaleState extends State<FinalFlashSale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#Flash ⚡ale',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('End in   '),
                  SlideCountdownClock(
                    duration: Duration(seconds: 10000),
                    slideDirection: SlideDirection.Up,
                    separator: ":",
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    separatorTextStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    tightLabel: true,
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.2),
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 17,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015),
            height: MediaQuery.of(context).size.height * 0.28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FinalFlashSaleBanner(
                  discPrice: "580",
                  oriprice: "999",
                  discount: "20",
                ),
                FinalFlashSaleBanner(
                  discPrice: "520",
                  oriprice: "890",
                  discount: "25",
                ),
                FinalFlashSaleBanner(
                  discPrice: "880",
                  oriprice: "1999",
                  discount: "10",
                ),
                FinalFlashSaleBanner(
                  discPrice: "1580",
                  oriprice: "8999",
                  discount: "15",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
