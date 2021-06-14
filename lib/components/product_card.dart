import 'package:ecom/screens/product_details/provider_models/ProductActions.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:ecom/models/Product.dart';

import '../utils.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final GestureTapCallback press;
  const ProductCard({
    Key key,
    @required this.productId,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width:70,
          height: 10,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.05),
            border: Border.all(color: kTextColor.withOpacity(0.15)),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.all(
            getProportionateScreenHeight(5)
          ),
          child: FutureBuilder<Product>(
              future: ProductDatabaseHelper().getProductWithID(productId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Product product = snapshot.data;
                  return buildProductCardItems(product, context);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  Logger().e(error);
                }
                return Center(
                  child: Icon(
                    Icons.error,
                    color: kTextColor,
                    size: 60,
                  ),
                );
              },
            ),
          ),
        ),
      
    );
  }

  Column buildProductCardItems(Product product, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.40,
          height: SizeConfig.screenWidth * 0.4,
          child: Image.network(
            product.images[0],
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "${product.title}\n",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(1)),
              Container(
                height: getProportionateScreenHeight(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 8,
                      child: Text.rich(
                        TextSpan(
                          text: "\₹${product.discountPrice} ",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                          children: [
                            TextSpan(
                              text: "\₹${product.originalPrice}",
                              style: TextStyle(
                                color: kTextColor,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ChangeNotifierProvider(
                          create: (context) => ProductActions(),
                          child: FutureBuilder<Product>(
                              future: ProductDatabaseHelper()
                                  .getProductWithID(productId),
                              builder: (context, snapshot) {
                                return Consumer<ProductActions>(
                                  builder: (context, productDetails, child) {
                                    return InkWell(
                                      onTap: () async {
                                        bool allowed = AuthentificationService()
                                            .currentUserVerified;
                                        if (!allowed) {
                                          final reverify =
                                              await showConfirmationDialog(
                                                  context,
                                                  "You haven't verified your email address. This action is only allowed for verified users.",
                                                  positiveResponse:
                                                      "Resend verification email",
                                                  negativeResponse: "Go back");
                                          if (reverify) {
                                            final future = AuthentificationService()
                                                .sendVerificationEmailToCurrentUser();
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return FutureProgressDialog(
                                                  future,
                                                  message: Text(
                                                      "Resending verification email"),
                                                );
                                              },
                                            );
                                          }
                                          return;
                                        }
                                        bool success = false;
                                        final future = UserDatabaseHelper()
                                            .switchProductFavouriteStatus(
                                                product.id,
                                                !productDetails
                                                    .productFavStatus)
                                            .then(
                                          (status) {
                                            success = status;
                                          },
                                        ).catchError(
                                          (e) {
                                            Logger().e(e.toString());
                                            success = false;
                                          },
                                        );
                                        await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FutureProgressDialog(
                                              future,
                                              message: Text(
                                                productDetails.productFavStatus
                                                    ? "Removing from Favourites"
                                                    : "Adding to Favourites",
                                              ),
                                            );
                                          },
                                        );
                                        if (success) {
                                          productDetails
                                              .switchProductFavStatus();
                                        }
                                      },
                                      child: Container(
                                        child: productDetails.productFavStatus
                                            ? Icon(
                                                Icons.favorite,
                                                color: kPrimaryColor,
                                                size: 25,
                                              )
                                            : Icon(
                                                Icons.favorite_outline,
                                                color: kPrimaryColor,
                                                size: 25,
                                              ),
                                      ),
                                    );
                                  },
                                );
                              })),
                    )
                    // Flexible(
                    //   flex: 3,
                    //   child: Stack(
                    //     children: [
                    //       SvgPicture.asset(
                    //         "assets/icons/DiscountTag.svg",
                    //         color: kPrimaryColor,
                    //       ),
                    //       Center(
                    //         child: Text(
                    //           "${product.calculatePercentageDiscount()}%\nOff",
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 8,
                    //             fontWeight: FontWeight.w900,
                    //           ),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
