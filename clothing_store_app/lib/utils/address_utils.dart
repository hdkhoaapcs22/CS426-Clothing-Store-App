import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address.dart';
import '../providers/address_model.dart';
import '../repositories/address_repository.dart';
import 'enum.dart';

mixin AddressUtils {
  static Future<List<String>> loadAddresses(BuildContext context) {
    final addressRepository =
        Provider.of<AddressRepository>(context, listen: false);
    return addressRepository.getAllStrings();
  }

  static void onChanged(BuildContext context, AddressModel addressModel,
      ActionType actionType, int? index) {
    final addressRepository =
        Provider.of<AddressRepository>(context, listen: false);

    switch (actionType) {
      case ActionType.add:
        addressRepository
            .add(Address.fromAddressString(addressModel.toString()));
        break;
      case ActionType.update:
        addressRepository.update(
            Address.fromAddressString(addressModel.toString()), index!);
        break;
      case ActionType.delete:
        addressRepository.delete(index!);
        break;
    }

    addressModel.clear();
  }
}
