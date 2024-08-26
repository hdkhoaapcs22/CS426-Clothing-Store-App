import 'package:clothing_store_app/providers/choose_coupon_provider.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';
import 'package:clothing_store_app/widgets/coupon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatelessWidget {
  final double totalAmount;
  CouponScreen({required this.totalAmount, super.key});

  final Stream<QuerySnapshot> couponStream = FirebaseFirestore.instance
      .collection('Coupon')
      .where('quantity', isGreaterThan: 0)
      .snapshots();

  get lottieSize => null;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChooseCouponProvider>(
      builder: (context, chosenCouponProvider, _) {
        return Scaffold(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          body: Padding(
            padding:
                EdgeInsets.fromLTRB(24, AppBar().preferredSize.height, 24, 10),
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
                StreamBuilder<QuerySnapshot>(
                    stream: couponStream,
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
                      List<Map<String, dynamic>> data = [];
                      for (int i = 0; i < dc.length; ++i) {
                        data.add(dc[i].data()! as Map<String, dynamic>);
                      }

                      if (chosenCouponProvider.initialized == false) {
                        chosenCouponProvider.initializeCoupon(data.length);
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            164,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return couponTicket(
                                context,
                                chosenCouponProvider,
                                data,
                                chosenCouponProvider.chosenCoupon,
                                totalAmount,
                                index);
                          },
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
