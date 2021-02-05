import 'package:ecom/constants.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class BannerSection extends StatefulWidget {
  List<String> urls;

  BannerSection(this.urls);
  @override
  _BannerSectionState createState() => _BannerSectionState();
}

List<Widget> banners = [];

class _BannerSectionState extends State<BannerSection> {
  loadbanners() async {
    for (var i in widget.urls)
      await banners.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red,
          child: FancyShimmerImage(
            height: 100,
            width: 100,
            imageUrl: i,
            shimmerDuration: Duration(seconds: 2),
          ),
        ),
      ));
  }

  @override
  void initState() {
    super.initState();
    loadbanners();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
            widget.urls.length,
            (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: kPrimaryColor.withOpacity(0.5),
                      child: FancyShimmerImage(
                        imageUrl: widget.urls[index],
                        shimmerDuration: Duration(seconds: 2),
                      ),
                    ),
                  ),
                )));
  }
}
