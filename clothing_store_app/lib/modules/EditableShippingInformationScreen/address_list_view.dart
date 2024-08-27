import 'package:flutter/material.dart';

import '../../models/shipping_information.dart';
import 'address_card.dart';

class AddressListView extends StatelessWidget {
  final List<String> addressList;
  final int selectedIndex;
  final void Function(int) onAddressTap;
  final void Function(ShippingInformation, int) onEditAddress;

  const AddressListView({
    Key? key,
    required this.addressList,
    required this.selectedIndex,
    required this.onAddressTap,
    required this.onEditAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        final shippingInformation =
            ShippingInformation.fromAddressString(addressList[index]);
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onAddressTap(index),
          child: AddressCard(
            shippingInformation: shippingInformation,
            isSelected: isSelected,
            index: index,
            onEdit: onEditAddress,
          ),
        );
      },
    );
  }
}
