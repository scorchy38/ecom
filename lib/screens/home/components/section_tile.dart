import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SectionTile extends StatelessWidget {
  final String title;
  final GestureTapCallback press;
  const SectionTile({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(16),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8
            ),
          ),
          InkWell(
            onTap: press,
            child: Text(
              'SEE ALL',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize:  getProportionateScreenWidth(13)),
                  // decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
