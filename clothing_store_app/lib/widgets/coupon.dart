import 'package:clothing_store_app/providers/choose_coupon_provider.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

Widget couponTicket(
    BuildContext context,
    ChooseCouponProvider pvd,
    List<Map<String, dynamic>> data,
    List<bool> chosenCoupon,
    double total,
    int index) {
  return TapEffect(
    isClickable:
        total < double.parse(data[index]['minimumTotalPrice']) ? false : true,
    onClick: () => pvd.updateChosenCoupon(index),
    child: Column(
      children: [
        TicketWidget(
          color: total < double.parse(data[index]['minimumTotalPrice'])
              ? Colors.grey
              : Colors.white,
          isCornerRounded: true,
          width: MediaQuery.of(context).size.width - 48,
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 24, 30, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]['title'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.all(2)),
                    Text(data[index]['requirement'],
                        style: TextStyles(context).getRegularStyle()),
                    const Padding(padding: EdgeInsets.all(2)),
                    Row(
                      children: [
                        const Icon(Icons.discount,
                            color: Color.fromARGB(255, 112, 79, 56)),
                        const Padding(padding: EdgeInsets.all(2)),
                        Text(data[index]['typeDiscount'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 48,
                height: 50,
                decoration: BoxDecoration(
                    color:
                        total < double.parse(data[index]['minimumTotalPrice'])
                            ? Colors.grey
                            : chosenCoupon[index] == true
                                ? const Color.fromARGB(255, 112, 79, 56)
                                : const Color.fromARGB(255, 222, 222, 222),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                    child: chosenCoupon[index] == true
                        ? const Text(
                            'APPLIED',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        : const Text(
                            'APPLY',
                            style: TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 112, 79, 56)),
                          )),
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(8)),
      ],
    ),
  );
}
