import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'active_order.dart';
import 'cancelled_order.dart';

// ignore: must_be_immutable
class MyOrder extends StatelessWidget {
  AnimationController animationController;
  MyOrder({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations(context).of("my_order"),
              style: TextStyles(context).getHeaderStyle(false)),
          bottom: TabBar(
            indicatorColor: AppTheme.brownColor,
            labelColor: AppTheme.brownColor,
            tabs: [
              Tab(
                  child: Text(
                AppLocalizations(context).of("active_order"),
                style: const TextStyle(fontSize: 18),
              )),
              Tab(
                  child: Text(AppLocalizations(context).of("cancelled_order"),
                      style: const TextStyle(fontSize: 18))),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveOrder(animationController: animationController),
            CancelledOrder(animationController: animationController),
          ],
        ),
      ),
    );
  }
}
