import 'package:ecom/constants.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/screens/product_details/components/product_actions_section.dart';
import 'package:ecom/screens/product_details/components/product_images.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'product_review_section.dart';

// class Body extends StatelessWidget {
//   final String productId;

//   const Body({
//     Key key,
//     @required this.productId,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: getProportionateScreenWidth(screenPadding)),
//           child: FutureBuilder<Product>(
//             future: ProductDatabaseHelper().getProductWithID(productId),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final product = snapshot.data;
//                 return Column(
//                   children: [
//                     SizedBox(
//                         height: 300, child: ProductImages(product: product)),
//                     SizedBox(height: getProportionateScreenHeight(10)),
//                     ProductActionsSection(product: product),
//                     SizedBox(height: getProportionateScreenHeight(10)),
//                     ProductReviewsSection(product: product),
//                     SizedBox(height: getProportionateScreenHeight(100)),
//                   ],
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 final error = snapshot.error.toString();
//                 Logger().e(error);
//               }
//               return Center(
//                 child: Icon(
//                   Icons.error,
//                   color: kTextColor,
//                   size: 60,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_image_upload/component/delivery-card.dart';
// import 'package:flutter_image_upload/component/product-detail.dart';

// import 'component/carousel.dart';

// import ''

class ProductData extends StatefulWidget {
  final String productId;

  const ProductData({
    Key key,
    @required this.productId,
  }) : super(key: key);
  // const ProductDetailScreen({ Key? key }) : super(key: key);

  @override
  _ProductDataState createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[300],
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: double.infinity,
                  child: ProductImageCarousel()),
              ProductDetail(),
              DeliveryCard(),
              DeliveryCard(),
              DeliveryCard(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      size: 35,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 35,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          // backgroundColor: MaterialStatePropertyColors.red,
                          // backgroundColor: MaterialStateProperty.all<Colors> Colors.blue,
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.black)))),
                      onPressed: () {},
                      child: Text('ADD TO BAG')),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}



class DeliveryCard extends StatelessWidget {
  // const DeliveryCard({ Key? key }) : super(key: key);

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery to'),
                ElevatedButton(
                  
                    style: ButtonStyle(
                        // elevation: 0,
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        // backgroundColor: MaterialStatePropertyColors.red,
                        // backgroundColor: MaterialStateProperty.all<Colors> Colors.blue,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.grey)
                                
                                ))),
                    onPressed: () {},
                    child: Text('Change pincode',style: TextStyle(
                      color: Colors.black
                    ),)
              )
              ],
            ),

            Divider(
              color: Colors.black,

            ),

            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.car_rental),
                  title: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text("Delivery in 4 days",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
              ),),
               ListTile(
                  leading: Icon(Icons.money),
                  title: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text("Cash on delivery",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
              ),),
               ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text("Free shipping for orders above over 900 Rs",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
              ),),

               ListTile(
                  leading: Icon(Icons.repeat_rounded),
                  title: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text("10 days easy return with free pick up",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
              
              trailing: Text('view',style: TextStyle(color: Colors.red),),
              ),
                
              ],
            )
          ],
        ),
    );
  }
}