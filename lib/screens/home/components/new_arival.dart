import 'package:ecom/screens/home/components/flash-sale-banner.dart';

import 'package:flutter/material.dart';

class NewArivalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.57,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "# New Arrivals ✨",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.20,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/ecom-9a689.appspot.com/o/Screenshot%202021-02-09%20at%203.33.09%20PM.png?alt=media&token=36a3ab05-dd7f-4909-a48f-8297dea48057"))),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015),
            height: MediaQuery.of(context).size.height * 0.28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
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
                FinalFlashSaleBanner(
                  discPrice: "580",
                  oriprice: "999",
                  discount: "30",
                ),
                FinalFlashSaleBanner(
                  discPrice: "520",
                  oriprice: "890",
                  discount: "12",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
