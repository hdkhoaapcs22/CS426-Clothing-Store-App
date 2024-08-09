import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
import 'package:clothing_store_app/widgets/coupon.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, AppBar().preferredSize.height, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const CommonAppBarView(iconData: Icons.arrow_back),
              Expanded(
                child: Center(
                  child: Text(
                    'Coupon        ',
                    style: TextStyles(context).getTitleStyle(),
                  ),
                ),
              ),
            ]),
            const Padding(padding: EdgeInsets.all(8)),
            const Text(
              'Best offers for you',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  164,
              child: ListView.builder(
                itemCount: couponName.length,
                itemBuilder: (BuildContext context, int index) {
                  return couponTicket(context, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
