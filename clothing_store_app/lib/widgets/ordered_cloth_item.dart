// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clothing_store_app/services/database/active_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../languages/appLocalizations.dart';
import '../utils/localfiles.dart';
import '../utils/text_styles.dart';
import 'common_app_bar_view.dart';

// ignore: must_be_immutable
class DetailClothItem extends StatelessWidget {
  String orderID;
  DetailClothItem({
    super.key,
    required this.orderID,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ActiveOrderService().getOrderDetailStream(orderID: orderID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> orderedItems = [];
            List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
            for (int i = 0; i < dc.length; ++i) {
              orderedItems.add(dc[i].data()! as Map<String, dynamic>);
            }

            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height, left: 5, right: 5),
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: CommonAppBarView(
                          topPadding: 0,
                          iconData: Icons.arrow_back,
                          onBackClick: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48),
                        child: Text(
                          AppLocalizations(context).of("detail_order"),
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 28,
                              ),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderedItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Product Image
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              orderedItems[index]['imageURL']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Product Details
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            orderedItems[index]['name'],
                                            style: TextStyles(context)
                                                .getBoldStyle()
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${AppLocalizations(context).of("size")}: ${orderedItems[index]['size']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.0),
                                                child: Text(
                                                  "||",
                                                  style: TextStyle(
                                                    fontSize:
                                                        16, // Adjust font size
                                                    color: Colors
                                                        .grey, // Adjust separator color
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${AppLocalizations(context).of("ordered_quantity")}: ${orderedItems[index]['orderQuantity']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '\$${double.parse(orderedItems[index]['price']) * orderedItems[index]['orderQuantity']}',
                                            style: TextStyles(context)
                                                .getBoldStyle()
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Lottie.asset(
                  Localfiles.loading,
                  width: MediaQuery.of(context).size.width * 0.2,
                ));
          }
        });
  }
}
