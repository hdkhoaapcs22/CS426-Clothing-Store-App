import 'package:clothing_store_app/modules/Home/common_product_widget.dart';
import 'package:clothing_store_app/modules/Home/custom_app_bar.dart';
import 'package:clothing_store_app/modules/Home/custom_circle_button.dart';
import 'package:clothing_store_app/modules/Home/home_tab.dart';
import 'package:clothing_store_app/modules/Home/slideshow_content.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/database/favorite_cloth.dart';
import 'package:clothing_store_app/widgets/bottom_move_top_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../class/cloth_item.dart';
import '../../global/global_var.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/tap_effect.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({super.key, required this.animationController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    widget.animationController.forward();
    _tabController = TabController(length: homeTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BannerContent> slides = _initSlides(context);
    final List<CustomCircleButton> buttons = _initializeButtons(context);
    final size = MediaQuery.of(context).size;
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return StreamBuilder(
        stream: FavoriteClothService().getFavoriteClothStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Lottie.asset(
                  Localfiles.loading,
                  width: lottieSize,
                ));
          }
          List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
          List<String> favoriteIds = dc.map((doc) => doc.id).toList();
          return BottomMoveTopAnimation(
            animationController: widget.animationController,
            child: Scaffold(
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: size.height / 1.9,
                        automaticallyImplyLeading: false,
                        backgroundColor: AppTheme.backgroundColor,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const CustomAppBar(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              searchAndSetting(context),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              ImageSlideshow(
                                indicatorColor: AppTheme.brownColor,
                                height: size.height / 5,
                                autoPlayInterval: 5000,
                                isLoop: true,
                                children: slides,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations(context)
                                              .of("categories"),
                                          style: TextStyles(context)
                                              .getHeaderStyle(false)
                                              .copyWith(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    SizedBox(
                                      height: size.height / 9,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: buttons.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: buttons[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: HomeTab(tabController: _tabController),
                      )
                    ];
                  },
                  body: Container(
                    color: AppTheme.backgroundColor,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProductGrid(
                            GlobalVar.listAllCloth, size, favoriteIds),
                        _buildProductGrid(
                            _filterClothesByReviews(GlobalVar.listAllCloth,
                                minReview: 4.5),
                            size,
                            favoriteIds),
                        _buildProductGrid(
                            _filterClothesByGender(GlobalVar.listAllCloth,
                                gender: 'M'),
                            size,
                            favoriteIds),
                        _buildProductGrid(
                            _filterClothesByGender(GlobalVar.listAllCloth,
                                gender: 'F'),
                            size,
                            favoriteIds),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

List<BannerContent> _initSlides(BuildContext context) {
  return [
    BannerContent(
      imagePath: Localfiles.homeImage1,
      title: AppLocalizations(context).of("new_collection"),
      description: AppLocalizations(context).of("new_collection_description"),
    ),
    BannerContent(
      imagePath: Localfiles.homeImage2,
      title: AppLocalizations(context).of("summer_sale"),
      description: AppLocalizations(context).of("summer_sale_description"),
    ),
    BannerContent(
      imagePath: Localfiles.homeImage3,
      title: AppLocalizations(context).of("exclusive_offer"),
      description: AppLocalizations(context).of("exclusive_offer_description"),
    ),
    BannerContent(
      imagePath: Localfiles.homeImage4,
      title: AppLocalizations(context).of("trending_now"),
      description: AppLocalizations(context).of("trending_now_description"),
    ),
  ];
}

List<CustomCircleButton> _initializeButtons(BuildContext context) {
  return [
    CustomCircleButton(
      imagePath: Localfiles.tshirtIcon,
      title: AppLocalizations(context).of("tshirt"),
      // radius: size.width / 15,
      onClick: () {
        NavigationServices(context).pushCategoryScreen("tshirt");
      },
    ),
    CustomCircleButton(
      imagePath: Localfiles.pantIcon,
      title: AppLocalizations(context).of("pant"),
      // radius: size.width / 15,
      onClick: () {
        NavigationServices(context).pushCategoryScreen("pant");
      },
    ),
    CustomCircleButton(
      imagePath: Localfiles.shirtIcon,
      title: AppLocalizations(context).of("shirt"),
      // radius: size.width / 15,
      onClick: () {
        NavigationServices(context).pushCategoryScreen("shirt");
      },
    ),
    CustomCircleButton(
      imagePath: Localfiles.jacketIcon,
      title: AppLocalizations(context).of("jacket"),
      // radius: size.width / 15,
      onClick: () {
        NavigationServices(context).pushCategoryScreen("jacket");
      },
    ),
  ];
}

Widget searchAndSetting(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            onTap: () {
              NavigationServices(context).gotoSearchScreen();
            },
            showCursor: false,
            readOnly: true,
            decoration: InputDecoration(
              fillColor: AppTheme.backgroundColor,
              filled: true,
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(
                  color: AppTheme.greyBackgroundColor,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(
                  color: AppTheme.greyBackgroundColor,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(
                  color: AppTheme.greyBackgroundColor,
                  width: 0.5,
                ),
              ),
              prefixIcon:
                  Icon(Iconsax.search_normal_1, color: AppTheme.brownColor),
              hintText: AppLocalizations(context).of("search"),
              hintStyle:
                  TextStyles(context).getLabelLargeStyle(true).copyWith(),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        TapEffect(
          onClick: () {
            NavigationServices(context).gotoFilterScreen();
          },
          child: CircleAvatar(
            backgroundColor: AppTheme.brownButtonColor,
            child: Icon(
              Iconsax.setting_4,
              size: 20,
              color: AppTheme.iconColor,
            ),
          ),
        ),
      ],
    ),
  );
}

List<String> homeTabs = ['All', 'Popular', 'Man', 'Woman'];

Widget _buildProductGrid(
    Map<String, ClothBase> clothes, Size size, List<String> favoriteList) {
  return GridView.builder(
      itemCount: clothes.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        mainAxisExtent: size.width / 2 + 10,
      ),
      itemBuilder: (context, index) {
        final clothKey = clothes.keys.elementAt(index);
        final clothBase = clothes[clothKey]!;
        final isFavorite = favoriteList.contains(clothBase.id);
        return FutureBuilder<List<ClothItem>>(
            future: clothBase.clothItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading'));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading product'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products found'));
              } else {
                final clothItem = snapshot.data!.first;
                return ProductCard(
                  image: clothItem.clothImageURL,
                  price: clothItem.price,
                  cloth: clothBase,
                  isFavorite: isFavorite,
                );
              }
            });
      });
}

Map<String, ClothBase> _filterClothesByGender(
  Map<String, ClothBase> clothes, {
  required String gender,
}) {
  return Map.fromEntries(
    clothes.entries.where((entry) => entry.value.gender == gender),
  );
}

Map<String, ClothBase> _filterClothesByReviews(
  Map<String, ClothBase> clothes, {
  required double minReview,
}) {
  return Map.fromEntries(
    clothes.entries.where((entry) => entry.value.review >= minReview),
  );
}
