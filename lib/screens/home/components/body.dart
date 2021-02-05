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
import 'package:ecom/services/data_streams/category_products_stream.dart';
import 'package:ecom/services/data_streams/favourite_products_stream.dart';
import 'package:ecom/services/database/product_database_helper.dart';
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
      ICON_KEY: "assets/icons/Electronics.svg",
      TITLE_KEY: "Sarojini Market",
      PRODUCT_TYPE_KEY: ProductType.Fashion,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Books.svg",
      TITLE_KEY: "Janpath Market",
      PRODUCT_TYPE_KEY: ProductType.Books,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Fashion.svg",
      TITLE_KEY: "Dilli Haat",
      PRODUCT_TYPE_KEY: ProductType.Electronics,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Groceries.svg",
      TITLE_KEY: "Paharganj Market",
      PRODUCT_TYPE_KEY: ProductType.Groceries,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Art.svg",
      TITLE_KEY: "Lajpat Nagar",
      PRODUCT_TYPE_KEY: ProductType.Art,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Others.svg",
      TITLE_KEY: "Karol Bagh",
      PRODUCT_TYPE_KEY: ProductType.Others,
    },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();
  final CategoryProductsStream sarojiniFashionStream =
      CategoryProductsStream(ProductType.Fashion);
  final CategoryProductsStream dilliHaatElectronicsStream =
      CategoryProductsStream(ProductType.Electronics);

  @override
  void initState() {
    super.initState();
    getBanners();
    favouriteProductsStream.init();
    allProductsStream.init();
    sarojiniFashionStream.init();
    dilliHaatElectronicsStream.init();
  }

  List<String> adBanners = [];
  String donationBanner = '';
  getBanners() async {
    final firestoreInstance = FirebaseFirestore.instance;

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
    super.dispose();
  }

  List imageList = [
    'https://firebasestorage.googleapis.com/v0/b/ecom-9a689.appspot.com/o/Screenshot%202021-02-05%20at%203.24.31%20PM.png?alt=media&token=2cbef62b-f220-4efe-ae76-2f88e70509f9',
    'https://firebasestorage.googleapis.com/v0/b/ecom-9a689.appspot.com/o/1548519881_maxresdefault.jpg?alt=media&token=442054ae-7461-4890-a4a5-b4be0dd62e18'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            bool allowed = AuthentificationService().currentUserVerified;
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
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            clipBehavior:
                Clip.none, // makes the stack clip over the overlapping widget
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                width: getProportionateScreenWidth(46),
                height: getProportionateScreenWidth(46),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  color: Color(0xFFFF4848),
                ),
              ),
              // if (numOfItems > 0)
              //   Positioned(
              //     right: 0,
              //     top: -3,
              //     child: Container(
              //       width: getProportionateScreenWidth(20),
              //       height: getProportionateScreenWidth(20),
              //       decoration: BoxDecoration(
              //         color: Color(0xFFFF4848),
              //         shape: BoxShape.circle,
              //       ),
              //       child: Center(
              //         child: Text(
              //           "$numOfItems",
              //           style: TextStyle(
              //             fontSize: getProportionateScreenWidth(10),
              //             color: Colors.white,
              //             height: 1,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        body: RefreshIndicator(
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
                    height: SizeConfig.screenHeight * 0.4,
                    child: ProductsSection(
                      sectionTitle: "Explore Sarojini Market",
                      productsStreamController: sarojiniFashionStream,
                      emptyListMessage: "Looks like all Stores are closed",
                      onProductCardTapped: onProductCardTapped,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.4,
                    child: ProductsSection(
                      sectionTitle: "Explore Dilli Haat",
                      productsStreamController: dilliHaatElectronicsStream,
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
                    height: SizeConfig.screenHeight * 0.4,
                    child: ProductsSection(
                      sectionTitle: "Explore All Products",
                      productsStreamController: allProductsStream,
                      emptyListMessage: "Looks like all Stores are closed",
                      onProductCardTapped: onProductCardTapped,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Your Wishlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                ],
              ),
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
