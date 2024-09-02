import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';
import '../../utils/text_styles.dart';

Widget orderUI(
    {required BuildContext context,
    required dynamic order,
    CommonButton? button}) {
  return TapEffect(
    onClick: () {
      NavigationServices(context).gotoDetailOrderScreen(order['orderID']);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Card(
        child: Column(
          children: [
            eachItemInOrderUI(
                title: "order_id",
                description: order['orderID'],
                context: context),
            eachItemInOrderUI(
                title: "order_date",
                description: order['orderDate'],
                context: context),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: DottedLine(
                dashColor: Colors.grey[400]!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  eachItemInOrderUI(
                      title: "quantity_item",
                      description: order['totalItems'].toString(),
                      context: context),
                  eachItemInOrderUI(
                      title: "total_price",
                      description: order['totalPrice'],
                      context: context),
                ],
              ),
            ),
            if (button != null)
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: button))
          ],
        ),
      ),
    ),
  );
}

Widget eachItemInOrderUI(
    {required String title,
    required String description,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(
          '${AppLocalizations(context).of(title)}: ',
          style: TextStyles(context).getBoldStyle().copyWith(
                fontSize: 18,
              ),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}
