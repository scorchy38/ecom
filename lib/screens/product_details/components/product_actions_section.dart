// import 'package:ecom/components/top_rounded_container.dart';
// import 'package:ecom/models/Product.dart';
// import 'package:ecom/screens/product_details/components/product_description.dart';
// import 'package:ecom/screens/product_details/provider_models/ProductActions.dart';
// import 'package:ecom/services/authentification/authentification_service.dart';
// import 'package:ecom/services/database/user_database_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';

// import '../../../size_config.dart';
// import '../../../utils.dart';

// class ProductActionsSection extends StatelessWidget {
//   final Product product;

//   const ProductActionsSection({
//     Key key,
//     @required this.product,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final column = Column(
//       children: [
//         Stack(
//           children: [
//             TopRoundedContainer(
//               child: ProductDescription(product: product),
//             ),
// //            Align(
// //              alignment: Alignment.topCenter,
// //              child: buildFavouriteButton(),
// //            ),
//           ],
//         ),
//       ],
//     );
//     UserDatabaseHelper().isProductFavourite(product.id).then(
//       (value) {
//         final productActions =
//             Provider.of<ProductActions>(context, listen: false);
//         productActions.productFavStatus = value;
//       },
//     ).catchError(
//       (e) {
//         Logger().w("$e");
//       },
//     );
//     return column;
//   }

//   Widget buildFavouriteButton() {
//     return Consumer<ProductActions>(
//       builder: (context, productDetails, child) {
//         return InkWell(
//           onTap: () async {
//             bool allowed = AuthentificationService().currentUserVerified;
//             if (!allowed) {
//               final reverify = await showConfirmationDialog(context,
//                   "You haven't verified your email address. This action is only allowed for verified users.",
//                   positiveResponse: "Resend verification email",
//                   negativeResponse: "Go back");
//               if (reverify) {
//                 final future = AuthentificationService()
//                     .sendVerificationEmailToCurrentUser();
//                 await showDialog(
//                   context: context,
//                   builder: (context) {
//                     return FutureProgressDialog(
//                       future,
//                       message: Text("Resending verification email"),
//                     );
//                   },
//                 );
//               }
//               return;
//             }
//             bool success = false;
//             final future = UserDatabaseHelper()
//                 .switchProductFavouriteStatus(
//                     product.id, !productDetails.productFavStatus)
//                 .then(
//               (status) {
//                 success = status;
//               },
//             ).catchError(
//               (e) {
//                 Logger().e(e.toString());
//                 success = false;
//               },
//             );
//             await showDialog(
//               context: context,
//               builder: (context) {
//                 return FutureProgressDialog(
//                   future,
//                   message: Text(
//                     productDetails.productFavStatus
//                         ? "Removing from Favourites"
//                         : "Adding to Favourites",
//                   ),
//                 );
//               },
//             );
//             if (success) {
//               productDetails.switchProductFavStatus();
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//             decoration: BoxDecoration(
//               color: productDetails.productFavStatus
//                   ? Color(0xFFFFE6E6)
//                   : Color(0xFFF5F6F9),
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 4),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//               child: Icon(
//                 Icons.favorite,
//                 color: productDetails.productFavStatus
//                     ? Color(0xFFFF4848)
//                     : Color(0xFFD8DEE4),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  // const ProductDetail({ Key? key }) : super(key: key);

  Widget greyCard(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey[600])),
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.01
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Product title goes here
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  'Positioning Prining Pull ovver ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  
                    style: ButtonStyle(
                      
                        backgroundColor: MaterialStateProperty.all(Colors.orange),
                        // backgroundColor: MaterialStatePropertyColors.red,
                        // backgroundColor: MaterialStateProperty.all<Colors> Colors.blue,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        Text('Share'),
                      ],
                    )),
              )
            ],
          ),
          Row(
            children: [
              Text('₹ 483', style: TextStyle(fontSize: 18, color: Colors.red)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                '₹ 483',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Color'),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context)
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context)
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context)
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context)
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Size'),
                  Row(
                    children: [Text('Size Chart'), Icon(Icons.arrow_right)],
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context),
                    greyCard('title', context)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
