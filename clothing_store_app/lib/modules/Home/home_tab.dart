import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Home/home_screen.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final TabController _tabController;

  const HomeTab({super.key, required TabController tabController})
      : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 30,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppTheme.brownButtonColor,
            borderRadius: BorderRadius.circular(15.0)
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          labelColor: AppTheme.backgroundColor,
          unselectedLabelColor: AppTheme.primaryTextColor,
          labelStyle: TextStyles(context).getInterDescriptionStyle(true, false).copyWith(fontSize: 14),
          unselectedLabelStyle: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 14, color: AppTheme.primaryTextColor),
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(15.0),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: List.generate(homeTabs.length, (index) => Tab(
            child: Container(
              width: size.width/5,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: index == _tabController.index
                        ? Colors.transparent
                        : AppTheme.secondaryTextColor,
                    width: 1.0,
                  ),
                ),
              child: Center(
                child: Text(
                  AppLocalizations(context).of(homeTabs[index]),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
