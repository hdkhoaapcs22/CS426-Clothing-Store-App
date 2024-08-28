import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'active_order.dart';
import 'cancelled_order.dart';
import 'completed_order.dart';

// ignore: must_be_immutable
class MyOrder extends StatelessWidget {
  AnimationController animationController;
  MyOrder({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Row(children: [
            const CommonAppBarView(iconData: Icons.arrow_back),
            Expanded(
              child: Center(
                child: Text(
                  AppLocalizations(context).of("my_order"),
                  style: TextStyles(context).getTitleStyle(),
                ),
              ),
            ),
          ]),
          bottom: TabBar(
            indicatorColor: AppTheme.brownColor,
            labelColor: AppTheme.brownColor,
            tabs: [
              Tab(
                  child: Text(AppLocalizations(context).of("active_order"),
                      style: TextStyles(context).getDescriptionStyle())),
              Tab(
                  child: Text(AppLocalizations(context).of("completed_order"),
                      style: TextStyles(context).getDescriptionStyle())),
              Tab(
                  child: Text(AppLocalizations(context).of("cancelled_order"),
                      style: TextStyles(context).getDescriptionStyle())),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrder(animationController: animationController),
            CompletedOrder(animationController: animationController),
            CancelledOrder(animationController: animationController),
          ],
        ),
      ),
    );
  }
}
