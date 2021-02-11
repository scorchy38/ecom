import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/components/icon_button_with_counter.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/models/Product.dart';
import 'package:ecom/screens/cart/cart_screen.dart';
import 'package:ecom/screens/category_products/category_products_screen.dart';
import 'package:ecom/screens/home/components/bannerSection.dart';
import 'package:ecom/screens/product_details/product_details_screen.dart';
import 'package:ecom/screens/search_result/search_result_screen.dart';
import 'package:ecom/screens/wishlist/wishlist_screen.dart';
import 'package:ecom/services/authentification/authentification_service.dart';
import 'package:ecom/services/data_streams/all_products_stream.dart';
import 'package:ecom/services/data_streams/cart_items_stream.dart';
import 'package:ecom/services/data_streams/category_products_stream.dart';
import 'package:ecom/services/data_streams/favourite_products_stream.dart';
import 'package:ecom/services/database/product_database_helper.dart';
import 'package:ecom/services/database/user_database_helper.dart';
import 'package:ecom/size_config.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:logger/logger.dart';
import '../../../utils.dart';
import '../components/home_header.dart';
import 'product_type_box.dart';
import 'products_section.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: "assets/icons/dress.svg",
      TITLE_KEY: "Sarojini Market",
      PRODUCT_TYPE_KEY: ProductType.Fashion,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/decor.svg",
      TITLE_KEY: "Janpath Market",
      PRODUCT_TYPE_KEY: ProductType.HomeDecor,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/electronic.svg",
      TITLE_KEY: "Dilli Haat",
      PRODUCT_TYPE_KEY: ProductType.Electronics,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/earrings.svg",
      TITLE_KEY: "Cannaught Place",
      PRODUCT_TYPE_KEY: ProductType.Handicrafts,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/vase.svg",
      TITLE_KEY: "Paharganj Market",
      PRODUCT_TYPE_KEY: ProductType.Art,
    },
    // <String, dynamic>{
    //   ICON_KEY: "assets/icons/Others.svg",
    //   TITLE_KEY: "Karol Bagh",
    //   PRODUCT_TYPE_KEY: ProductType.Others,
    // },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();
  final CategoryProductsStream sarojiniFashionStream =
      CategoryProductsStream(ProductType.Fashion);
  final CategoryProductsStream dilliHaatElectronicsStream =
      CategoryProductsStream(ProductType.Electronics);
  final CartItemsStream cartItemsStream = CartItemsStream();

  @override
  void initState() {
    super.initState();
    getBanners();
    favouriteProductsStream.init();
    allProductsStream.init();
    sarojiniFashionStream.init();
    dilliHaatElectronicsStream.init();
    cartItemsStream.init();
  }

  List<String> adBanners = [];
  String donationBanner = '';
  int cartLen;
  getBanners() async {
    final firestoreInstance = FirebaseFirestore.instance;
    cartLen = await UserDatabaseHelper().getCartLength();
    await firestoreInstance.collection("banners").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.data()['type'] == 'adBanner')
          adBanners.add(result.data()['url']);
        if (result.data()['type'] == 'donationBanner')
          donationBanner = result.data()['url'];
      });
    });
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    sarojiniFashionStream.dispose();
    dilliHaatElectronicsStream.dispose();
    cartItemsStream.dispose();
    super.dispose();
  }

  List imageList = [
    'https://firebasestorage.googleapis.com/v0/b/ecom-9a689.appspot.com/o/Screenshot%202021-02-09%20at%203.28.45%20PM.png?alt=media&token=816f535f-7a05-4bea-b415-5bbaa698f5c8',
    'https://firebasestorage.googleapis.com/v0/b/ecom-9a689.appspot.com/o/Screenshot%202021-02-09%20at%203.33.09%20PM.png?alt=media&token=36a3ab05-dd7f-4909-a48f-8297dea48057'
  ];
  //        floatingActionButton: InkWell(
//          onTap: () async {
//            bool allowed = AuthentificationService().currentUserVerified;
//            if (!allowed) {
//              final reverify = await showConfirmationDialog(context,
//                  "You haven't verified your email address. This action is only allowed for verified users.",
//                  positiveResponse: "Resend verification email",
//                  negativeResponse: "Go back");
//              if (reverify) {
//                final future = AuthentificationService()
//                    .sendVerificationEmailToCurrentUser();
//                await showDialog(
//                  context: context,
//                  builder: (context) {
//                    return FutureProgressDialog(
//                      future,
//                      message: Text("Resending verification email"),
//                    );
//                  },
//                );
//              }
//              return;
//            }
//            await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => WishlistScreen(),
//              ),
//            );
//            await refreshPage();
//          },
//          borderRadius: BorderRadius.circular(50),
//          child: Stack(
//            clipBehavior:
//                Clip.none, // makes the stack clip over the overlapping widget
//            children: [
//              Container(
//                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
//                width: getProportionateScreenWidth(46),
//                height: getProportionateScreenWidth(46),
//                decoration: BoxDecoration(
//                  color: kPrimaryColor.withOpacity(0.5),
//                  shape: BoxShape.circle,
//                ),
//                child: Icon(
//                  Icons.favorite,
//                  color: Color(0xFFFF4848),
//                ),
//              ),
//              // if (numOfItems > 0)
//              //   Positioned(
//              //     right: 0,
//              //     top: -3,
//              //     child: Container(
//              //       width: getProportionateScreenWidth(20),
//              //       height: getProportionateScreenWidth(20),
//              //       decoration: BoxDecoration(
//              //         color: Color(0xFFFF4848),
//              //         shape: BoxShape.circle,
//              //       ),
//              //       child: Center(
//              //         child: Text(
//              //           "$numOfItems",
//              //           style: TextStyle(
//              //             fontSize: getProportionateScreenWidth(10),
//              //             color: Colors.white,
//              //             height: 1,
//              //             fontWeight: FontWeight.w600,
//              //           ),
//              //         ),
//              //       ),
//              //     ),
//              //   ),
//            ],
//          ),
//        ),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(screenPadding)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: getProportionateScreenHeight(15)),
                HomeHeader(
                  cartLen: cartLen,
                  cartItemsStream: cartItemsStream,
                  onSearchSubmitted: (value) async {
                    final query = value.toString();
                    if (query.length <= 0) return;
                    List<String> searchedProductsId;
                    try {
                      searchedProductsId = await ProductDatabaseHelper()
                          .searchInProducts(query.toLowerCase());
                      if (searchedProductsId != null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultScreen(
                              searchQuery: query,
                              searchResultProductsId: searchedProductsId,
                              searchIn: "All Products",
                            ),
                          ),
                        );
                        await refreshPage();
                      } else {
                        throw "Couldn't perform search due to some unknown reason";
                      }
                    } catch (e) {
                      final error = e.toString();
                      Logger().e(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$error"),
                        ),
                      );
                    }
                  },
                  onCartButtonPressed: () async {
                    bool allowed =
                        AuthentificationService().currentUserVerified;
                    if (!allowed) {
                      final reverify = await showConfirmationDialog(context,
                          "You haven't verified your email address. This action is only allowed for verified users.",
                          positiveResponse: "Resend verification email",
                          negativeResponse: "Go back");
                      if (reverify) {
                        final future = AuthentificationService()
                            .sendVerificationEmailToCurrentUser();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return FutureProgressDialog(
                              future,
                              message: Text("Resending verification email"),
                            );
                          },
                        );
                      }
                      return;
                    }
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                    await refreshPage();
                  },
                  onWishlistButtonPressed: () async {
                    bool allowed =
                        AuthentificationService().currentUserVerified;
                    if (!allowed) {
                      final reverify = await showConfirmationDialog(context,
                          "You haven't verified your email address. This action is only allowed for verified users.",
                          positiveResponse: "Resend verification email",
                          negativeResponse: "Go back");
                      if (reverify) {
                        final future = AuthentificationService()
                            .sendVerificationEmailToCurrentUser();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return FutureProgressDialog(
                              future,
                              message: Text("Resending verification email"),
                            );
                          },
                        );
                      }
                      return;
                    }
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistScreen(),
                      ),
                    );
                    await refreshPage();
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                GFCarousel(
                  items: imageList.map(
                    (url) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: FancyShimmerImage(
                            shimmerDuration: Duration(seconds: 2),
                            imageUrl: '$url',
                            width: 10000.0,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      //                                    print('change');
                    });
                  },
                  viewportFraction: 1.0,
                  aspectRatio: (MediaQuery.of(context).size.width / 28) /
                      (MediaQuery.of(context).size.width / 50),
                  autoPlay: true,
                  pagination: true,
                  passiveIndicator: Colors.grey.withOpacity(0.4),
                  activeIndicator: Colors.white,
                  pauseAutoPlayOnTouch: Duration(seconds: 8),
                  pagerSize: 8,
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: [
                        ...List.generate(
                          productCategories.length,
                          (index) {
                            return ProductTypeBox(
                              icon: productCategories[index][ICON_KEY],
                              title: productCategories[index][TITLE_KEY],
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryProductsScreen(
                                      productType: productCategories[index]
                                          [PRODUCT_TYPE_KEY],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                adBanners.length >= 2
                    ? SizedBox(
                        height: SizeConfig.screenHeight * 0.2,
                        width: SizeConfig.screenWidth,
                        child: BannerSection([adBanners[0], adBanners[1]]),
                      )
                    : Container(),
                // SizedBox(height: getProportionateScreenHeight(20)),
                // SizedBox(
                //   height: SizeConfig.screenHeight * 0.4,
                //   child: ProductsSection(
                //     sectionTitle: "Products You Like",
                //     productsStreamController: favouriteProductsStream,
                //     emptyListMessage: "Add Product to Favourites",
                //     onProductCardTapped: onProductCardTapped,
                //   ),
                // ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                  height: SizeConfig.screenWidth * 1.6,
                  child: ProductsSection(
                    sectionTitle: "Explore Sarojini Market",
                    productType: ProductType.Fashion,
                    productsStreamController: sarojiniFashionStream,
                    emptyListMessage: "Looks like all Stores are closed",
                    onProductCardTapped: onProductCardTapped,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                  height: SizeConfig.screenWidth * 1.6,
                  child: ProductsSection(
                    sectionTitle: "Explore Dilli Haat",
                    productsStreamController: dilliHaatElectronicsStream,
                    productType: ProductType.Electronics,
                    emptyListMessage: "Looks like all Stores are closed",
                    onProductCardTapped: onProductCardTapped,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                adBanners.length >= 4
                    ? SizedBox(
                        height: SizeConfig.screenHeight * 0.2,
                        width: SizeConfig.screenWidth,
                        child: BannerSection([adBanners[2], adBanners[3]]),
                      )
                    : Container(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.2,
                  width: SizeConfig.screenWidth,
                  child: FancyShimmerImage(
                    imageUrl: donationBanner,
                    shimmerDuration: Duration(seconds: 2),
                  ),
                ),

                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox(
                  height: SizeConfig.screenWidth * 1.6,
                  child: ProductsSection(
                    productType: ProductType.Others,
                    sectionTitle: "Explore All Products",
                    productsStreamController: allProductsStream,
                    emptyListMessage: "Looks like all Stores are closed",
                    onProductCardTapped: onProductCardTapped,
                  ),
                ),
                // SizedBox(height: getProportionateScreenHeight(20)),
                // Container(
                //   width: SizeConfig.screenWidth,
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color: kPrimaryColor,
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                //   child: Center(
                //     child: Text(
                //       'Your Wishlist',
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.w700),
                //     ),
                //   ),
                // ),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    sarojiniFashionStream.reload();
    dilliHaatElectronicsStream.reload();
    cartItemsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
