// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../languages/appLocalizations.dart';
import '../utils/text_styles.dart';

// ignore: must_be_immutable
class DetailClothItem extends StatelessWidget {
  dynamic itemCloth;
  CommonButton? button;
  DetailClothItem({
    super.key,
    required this.itemCloth,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Product Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(itemCloth.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    itemCloth.name,
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 16,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${AppLocalizations(context).of("size")}: ${itemCloth.size}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: VerticalDivider(
                          color: Colors.grey, // Match the color as needed
                          thickness: 1, // Adjust thickness to match the design
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${itemCloth.price}',
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),

          if (button != null) ...{Expanded(child: button!)}
          // Quantity Control
        ],
      ),
    );
  }
}
