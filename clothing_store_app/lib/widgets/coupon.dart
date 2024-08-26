import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

final List<String> couponName = <String>[
  'WELCOME10',
  'WELCOME20',
  'WELCOME50',
  'WELCOME100',
  'WELCOME200',
  'WELCOME500',
  'WELCOME10%',
  'WELCOME25%',
  'WELCOME50%',
  'WELCOME75%'
];
final List<String> couponDes = <String>[
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$',
  'For purchase above 50\$'
];
final List<String> couponVal = <String>[
  'Get 10\$ OFF',
  'Get 20\$ OFF',
  'Get 50\$ OFF',
  'Get 100\$ OFF',
  'Get 200\$ OFF',
  'Get 500\$ OFF',
  'Get 10% OFF',
  'Get 20% OFF',
  'Get 50% OFF',
  'Get 75% OFF'
];

Widget couponTicket(BuildContext context, int index) {
  return TapEffect(
    onClick: () {},
    child: Column(
      children: [
        TicketWidget(
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
                    Text(couponName[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.all(2)),
                    Text(couponDes[index],
                        style: TextStyles(context).getDescriptionStyle()),
                    const Padding(padding: EdgeInsets.all(2)),
                    Row(
                      children: [
                        const Icon(Icons.discount,
                            color: Color.fromARGB(255, 112, 79, 56)),
                        const Padding(padding: EdgeInsets.all(2)),
                        Text(couponVal[index],
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
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 222, 222, 222),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Center(
                    child: Text(
                  'APPLY',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 112, 79, 56)),
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
