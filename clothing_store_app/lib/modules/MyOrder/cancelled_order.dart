import 'package:clothing_store_app/services/database/cancelled_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';
import '../../widgets/bottom_move_top_animation.dart';
import 'order_ui.dart';

class CancelledOrder extends StatefulWidget {
  final AnimationController animationController;
  const CancelledOrder({super.key, required this.animationController});

  @override
  State<CancelledOrder> createState() => _CancelledOrderState();
}

class _CancelledOrderState extends State<CancelledOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CancelledOrderService().getCancelledOrderStream(),
      builder: (context, snapshot) {
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
                    );
                  },
                ),
              ));
        } else {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ));
        }
      },
    );
  }
}
