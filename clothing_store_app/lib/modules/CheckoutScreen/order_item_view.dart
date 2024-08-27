import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class OrderItemView extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final double price;

  OrderItemView({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Size: $size'),
          MediaQuery.of(context).size.width > 360
              ? SizedBox(height: 10)
              : SizedBox(height: 6),
          Text(
            '\$$price',
            style: TextStyles(context).getRegularStyle(),
          ),
        ],
      ),
    );
  }
}
