import 'package:clothing_store_app/services/database/active_order.dart';
import 'package:clothing_store_app/widgets/common_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/bottom_move_top_animation.dart';
import '../../widgets/common_button.dart';
import 'order_ui.dart';

class ActiveOrder extends StatefulWidget {
  final AnimationController animationController;
  const ActiveOrder({super.key, required this.animationController});

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  void initState() {
    super.initState();
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ActiveOrderService().getOrderStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ));
        }
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
          List<dynamic> listOrders = [];
          for (int i = 0; i < dc.length; ++i) {
            listOrders.add(dc[i].data()! as Map<String, dynamic>);
          }
          return BottomMoveTopAnimation(
              animationController: widget.animationController,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: listOrders.length,
                  itemBuilder: (context, index) {
                    return orderUI(
                        context: context,
                        order: listOrders[index],
                        button: CommonButton(
                          padding: const EdgeInsets.only(top: 5, right: 10),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.3,
                          onTap: () async {
                            Dialogs(context).showLoadingDialog;
                            ActiveOrderService().removeOrder(
                              orderID: listOrders[index]["orderID"],
                              totalPrice: listOrders[index]["totalPrice"],
                              orderDate: listOrders[index]["orderDate"],
                              totalItems: listOrders[index]["totalItems"],
                            );
                            // setState(() {});
                          },
                          radius: 30.0,
                          backgroundColor: AppTheme.brownButtonColor,
                          buttonTextWidget: Text(
                            AppLocalizations(context).of("cancel"),
                            style: TextStyles(context)
                                .getButtonTextStyle()
                                .copyWith(fontSize: 16),
                          ),
                        ));
                  },
                ),
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
