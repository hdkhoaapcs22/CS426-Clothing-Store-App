import 'package:clothing_store_app/class/ordered_item.dart';
import 'package:clothing_store_app/services/database/cancelled_order.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../languages/appLocalizations.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/bottom_move_top_animation.dart';
import '../../widgets/ordered_cloth_item.dart';

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
          List<OrderedItem> listItems = snapshot.data!.docs
              .map((doc) => OrderedItem(
                    clothBaseID: doc['clothItemID'],
                    name: doc['name'],
                    imageURL: doc['imageURL'],
                    size: doc['size'],
                    price: double.parse(doc['price']),
                    orderQuantity: doc['orderQuantity'],
                    quantity: doc['quantity'],
                  ))
              .toList();
          return BottomMoveTopAnimation(
              animationController: widget.animationController,
              child: ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return DetailClothItem(
                      itemCloth: listItems[index],
                      button: CommonButton(
                        padding: const EdgeInsets.only(top: 5, right: 10),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        onTap: () async {
                          // 
                        },
                        radius: 30.0,
                        backgroundColor: AppTheme.brownButtonColor,
                        buttonTextWidget: Text(
                          AppLocalizations(context).of("re_order"),
                          style: TextStyles(context)
                              .getButtonTextStyle()
                              .copyWith(fontSize: 16),
                        ),
                      ));
                },
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
