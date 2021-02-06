import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class ReviewBox extends StatefulWidget {
  final Review review;
  const ReviewBox({
    Key key,
    @required this.review,
  }) : super(key: key);

  @override
  _ReviewBoxState createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  String url;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.review.reviewerUid)
              .get()
              .then((value) {
            setState(() {
              url = value['display_picture'];
            });
          });
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: kTextColor.withOpacity(0.075),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: url != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(url),
                          )
                        : CircleAvatar(
                            radius: 40,
                            backgroundColor: kTextColor.withOpacity(0.1),
                            child: SvgPicture.asset(
                              "assets/icons/User.svg",
                              color: kTextColor,
                              width: 40,
                            ),
                          )),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.review.feedback,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      "${widget.review.rating}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
