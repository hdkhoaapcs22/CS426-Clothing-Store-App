import 'package:flutter/material.dart';
import '../../../models/shipping_information.dart';
import 'address_item.dart';

class AddressList extends StatelessWidget {
  final List<String> addressList;
  final void Function(int) onAddressTap;
  final int selectedIndex;

  const AddressList({
    Key? key,
    required this.addressList,
    required this.onAddressTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        final addressData = addressList[index];
        ShippingInformation address = ShippingInformation.fromAddressString(addressData);

        return AddressItem(
          shippingInformation: address,
          index: index,
          selectedIndex: selectedIndex,
          onSelect: onAddressTap,
        );
      },
    );
  }
}
