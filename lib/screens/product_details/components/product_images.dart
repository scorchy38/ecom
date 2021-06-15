// import 'package:ecom/models/Product.dart';
// import 'package:ecom/screens/product_details/provider_models/ProductImageSwiper.dart';
// import 'package:flutter/material.dart';
// //import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
// import 'package:provider/provider.dart';
// import 'package:swipedetector/swipedetector.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';

// class ProductImages extends StatelessWidget {
//   const ProductImages({
//     Key key,
//     @required this.product,
//   }) : super(key: key);

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ProductImageSwiper(),
//       child: Consumer<ProductImageSwiper>(
//         builder: (context, productImagesSwiper, child) {
//           return Container(
//             height: 300,
//             width: SizeConfig.screenWidth,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SwipeDetector(
//                     onSwipeLeft: () {
//                       productImagesSwiper.currentImageIndex++;
//                       productImagesSwiper.currentImageIndex %=
//                           product.images.length;
//                     },
//                     onSwipeRight: () {
//                       productImagesSwiper.currentImageIndex--;
//                       productImagesSwiper.currentImageIndex +=
//                           product.images.length;
//                       productImagesSwiper.currentImageIndex %=
//                           product.images.length;
//                     },
//                     child:
// //                PinchZoomImage(
// //                  image:
//                         Container(
//                       // padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                             product
//                                 .images[productImagesSwiper.currentImageIndex],
//                             fit: BoxFit.fill),
//                       ),
//                     ),
//                   ),
//                 ),
// //              ),

//                 Container(
//                   height: 300,
//                   width: 100,
//                   child: ListView.builder(
//                     itemCount: product.images.length,
//                     itemBuilder: (context, index) {
//                       return buildSmallPreview(productImagesSwiper,
//                           index: index);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildSmallPreview(ProductImageSwiper productImagesSwiper,
//       {@required int index}) {
//     return GestureDetector(
//       onTap: () {
//         productImagesSwiper.currentImageIndex = index;
//       },
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(8)),
//             // padding: EdgeInsets.all(getProportionateScreenHeight(8)),
//             height: getProportionateScreenWidth(58),
//             width: getProportionateScreenWidth(58),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                   color: productImagesSwiper.currentImageIndex == index
//                       ? kPrimaryColor
//                       : Colors.transparent),
//             ),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Image.network(product.images[index], fit: BoxFit.fill)),
//           ),
//           SizedBox(
//             height: 5,
//           )
//         ],
//       ),
//     );
//   }
// }
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ProductImageCarousel extends StatelessWidget {

  final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    // height: MediaQuery.of(context).size.height ,
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network(item, fit: BoxFit.fill, width: 500.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. ${imgList.indexOf(item)} image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  ),
)).toList();


Widget imageContainer(String imageUrl,BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.50,
    width: MediaQuery.of(context).size.width * 0.9,
    margin: EdgeInsets.only(
      right: 2
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(imageUrl)
      )
    ),
    // child: ,D
  );
}

Widget productOverLayIcon(Icon icon,double height , double width , BuildContext context){
  return Positioned(
              top: MediaQuery.of(context).size.height * height,
              left: MediaQuery.of(context).size.width * width,
              child:  Container(
              
              decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(20)
              ),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.10,
              child: icon,
            ));
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(title: Text('Complicated image slider demo')),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width:double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  imageContainer('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80', context),
                  imageContainer('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80', context),
                  imageContainer('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80', context),

                ],
              ),
            ),

            productOverLayIcon(Icon(Icons.arrow_back), 0.04, 0.03, context),

           productOverLayIcon(Icon(Icons.search), 0.04, 0.18, context),

           productOverLayIcon(Icon(Icons.headset), 0.04, 0.60, context),

           productOverLayIcon(Icon(Icons.shopping_basket), 0.04, 0.75, context),

           productOverLayIcon(Icon(Icons.shopping_bag), 0.04, 0.90, context),

           Positioned(
             bottom: MediaQuery.of(context).size.height * 0.01,
             right: MediaQuery.of(context).size.width * 0.03,
             child: Container(
               alignment: Alignment.center,
               height: MediaQuery.of(context).size.height * 0.04,
               
               width:MediaQuery.of(context).size.width * 0.15 ,
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                 borderRadius: BorderRadius.circular(15)
               ),
             child: Text('1/16'),
           ))
        ],
      ),
    );
  }
}