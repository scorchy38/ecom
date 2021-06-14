import 'package:ecom/models/Product.dart';
import 'package:ecom/screens/product_details/provider_models/ProductImageSwiper.dart';
import 'package:flutter/material.dart';
//import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductImageSwiper(),
      child: Consumer<ProductImageSwiper>(
        builder: (context, productImagesSwiper, child) {
          return Container(
            height: 300,
            width: SizeConfig.screenWidth,
            child: Row(
              children: [
                Expanded(
                  child: SwipeDetector(
                    onSwipeLeft: () {
                      productImagesSwiper.currentImageIndex++;
                      productImagesSwiper.currentImageIndex %=
                          product.images.length;
                    },
                    onSwipeRight: () {
                      productImagesSwiper.currentImageIndex--;
                      productImagesSwiper.currentImageIndex +=
                          product.images.length;
                      productImagesSwiper.currentImageIndex %=
                          product.images.length;
                    },
                    child:
//                PinchZoomImage(
//                  image:
                        Container(
                      // padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            product
                                .images[productImagesSwiper.currentImageIndex],
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
//              ),

                Container(
                  height: 300,
                  width: 100,
                  child: ListView.builder(
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      return buildSmallPreview(productImagesSwiper,
                          index: index);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSmallPreview(ProductImageSwiper productImagesSwiper,
      {@required int index}) {
    return GestureDetector(
      onTap: () {
        productImagesSwiper.currentImageIndex = index;
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8)),
            // padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            height: getProportionateScreenWidth(58),
            width: getProportionateScreenWidth(58),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: productImagesSwiper.currentImageIndex == index
                      ? kPrimaryColor
                      : Colors.transparent),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(product.images[index], fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
