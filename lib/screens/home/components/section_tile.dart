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
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: press,
            child: Text(
              'See all',
              style: TextStyle(
                  color: kPrimaryColor.withOpacity(0.7),
                  fontSize: 15,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
