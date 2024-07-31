import 'package:flutter/material.dart';
import '../../models/address.dart';
import '../../utils/text_styles.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final int index;
  final void Function(Address, int) onEdit;

  const AddressCard({
    Key? key,
    required this.address,
    required this.isSelected,
    required this.index,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeInsets = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.symmetric(horizontal: 200.0, vertical: 8.0)
        : const EdgeInsets.all(8.0);

    final padding = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.all(16.0)
        : const EdgeInsets.all(8.0);

    return Container(
      margin: edgeInsets,
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
                Text(address.name,
                    style: TextStyles(context).getRegularStyle()),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(address.phoneNumber,
                    style: TextStyles(context).getSubtitleStyle()),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  '${address.street}, ${address.ward}, ${address.district}, ${address.city}',
                  style: TextStyles(context).getSubtitleStyle(),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => onEdit(address, index),
          ),
        ],
      ),
    );
  }
}
