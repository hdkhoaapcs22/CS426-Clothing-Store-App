import 'package:flutter/material.dart';
import '../../../models/shipping_information.dart';
import '../../../utils/text_styles.dart';

class AddressItem extends StatelessWidget {
  final ShippingInformation shippingInformation;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AddressItem({
    Key? key,
    required this.shippingInformation,
    required this.index,
    required this.selectedIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final padding = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.all(16.0)
        : const EdgeInsets.all(8.0);
    final margin = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.symmetric(horizontal: 200.0, vertical: 8.0)
        : const EdgeInsets.all(8.0);

    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shippingInformation.name,
                    style: TextStyles(context).getRegularStyle(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    shippingInformation.phoneNumber,
                    style: TextStyles(context).getSubtitleStyle(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    '${shippingInformation.street}, ${shippingInformation.ward}, ${shippingInformation.district}, ${shippingInformation.city}',
                    style: TextStyles(context).getSubtitleStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
