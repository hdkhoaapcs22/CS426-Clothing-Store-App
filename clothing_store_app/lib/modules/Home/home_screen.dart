import 'package:clothing_store_app/modules/Home/custom_app_bar.dart';
import 'package:clothing_store_app/modules/Home/custom_circle_button.dart';
import 'package:clothing_store_app/modules/Home/home_tab.dart';
import 'package:clothing_store_app/modules/Home/slideshow_content.dart';
import 'package:clothing_store_app/providers/home_tab_provider.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/bottom_move_top_animation.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({super.key, required this.animationController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _curId = 0;

  @override
  void initState(){
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController.addListener(_handleSelection);
    super.initState();
  }

  void _handleSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);

    if (_tabController.indexIsChanging) {
      setState(() {
        _curId = _tabController.index;
      });
      controller.setIndex(homeTabs[_curId]);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<SlideShowContent> slides = _initSlides(context);
    final List<CustomCircleButton> buttons = _initializeButtons(context);
    return BottomMoveTopAnimation(
        animationController: widget.animationController,
        child: Column(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 20,
            ),
            searchAndSetting(context),
            const SizedBox(
              height: 20,
            ),
            ImageSlideshow(
              indicatorColor: AppTheme.brownColor,
              autoPlayInterval: 5000,
              isLoop: true,
              children: slides,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyles(context)
                            .getHeaderStyle(false)
                            .copyWith(fontSize: 16),
                      ),
                      TapEffect(
                          onClick: () {},
                          child: Text(
                            'See all',
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: buttons.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: buttons[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            HomeTab(tabController: _tabController)
          ],
        ));
  }
}

List<SlideShowContent> _initSlides(BuildContext context) {
  return [
    SlideShowContent(
      imagePath: Localfiles.homeImage1,
      title: AppLocalizations(context).of("new_collection"),
      description: AppLocalizations(context).of("new_collection_description"),
    ),
    SlideShowContent(
      imagePath: Localfiles.homeImage2,
      title: AppLocalizations(context).of("summer_sale"),
      description: AppLocalizations(context).of("summer_sale_description"),
    ),
    SlideShowContent(
      imagePath: Localfiles.homeImage3,
      title: AppLocalizations(context).of("exclusive_offer"),
      description: AppLocalizations(context).of("exclusive_offer_description"),
    ),
    SlideShowContent(
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
    ),
    CustomCircleButton(
      imagePath: Localfiles.pantIcon,
      title: AppLocalizations(context).of("pant"),
    ),
    CustomCircleButton(
      imagePath: Localfiles.dressIcon,
      title: AppLocalizations(context).of("dress"),
    ),
    CustomCircleButton(
      imagePath: Localfiles.jacketIcon,
      title: AppLocalizations(context).of("jacket"),
    ),
    CustomCircleButton(
      imagePath: Localfiles.shoesIcon,
      title: AppLocalizations(context).of("shoes"),
    ),
    CustomCircleButton(
      imagePath: Localfiles.accessoryIcon,
      title: AppLocalizations(context).of("accessory"),
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
            controller: TextEditingController(),
            onChanged: (value) => {},
            cursorColor: AppTheme.brownColor,
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
          onClick: () {},
          child: CircleAvatar(
            backgroundColor: AppTheme.brownButtonColor,
            child: Icon(
              Iconsax.setting_4,
              size: 20,
              color: AppTheme.iconColor,
            ),
          ),
        )
      ],
    ),
  );
}

List<String> homeTabs = ['All', 'Newest', 'Popular', 'Man', 'Woman', 'Kids'];