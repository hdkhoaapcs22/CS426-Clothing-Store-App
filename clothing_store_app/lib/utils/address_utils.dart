import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shipping_information.dart';
import '../providers/shipping_information_model.dart';
import '../repositories/shipping_information_repository.dart';
import 'enum.dart';

class AddressUtils {
  static Future<List<String>> loadAddresses(BuildContext context) {
    final shippingInformationRepository =
        Provider.of<ShippingInformationRepository>(context, listen: false);
    return shippingInformationRepository.getAllStrings();
  }

  static void onChanged(
      BuildContext context,
      ShippingInformationModel shippingInformationModel,
      ActionType actionType,
      int? index) {
    final shippingInformationRepository =
        Provider.of<ShippingInformationRepository>(context, listen: false);

    switch (actionType) {
      case ActionType.add:
        shippingInformationRepository.add(ShippingInformation.fromAddressString(
            shippingInformationModel.toString()));
        break;
      case ActionType.update:
        shippingInformationRepository.update(
            ShippingInformation.fromAddressString(
                shippingInformationModel.toString()),
            index!);
        break;
      case ActionType.delete:
        shippingInformationRepository.delete(index!);
        break;
    }

    shippingInformationModel.clear();
  }
}
