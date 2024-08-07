import 'package:flutter/material.dart';
import '../../../providers/shipping_information_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/notification_utils.dart';
import '../../../widgets/common_button.dart';
import '../../../utils/address_utils.dart';

class SaveButton extends StatelessWidget {
  final ShippingInformationModel shippingInformationModel;
  final ActionType actionType;
  final int? index;

  const SaveButton({
    Key? key,
    required this.shippingInformationModel,
    required this.actionType,
    this.index,
  }) : super(key: key);

  bool isFormValid() {
    return shippingInformationModel.fullNameController!.text.isNotEmpty &&
        shippingInformationModel.phoneNumberController!.text.isNotEmpty &&
        shippingInformationModel.addressController!.text.isNotEmpty &&
        shippingInformationModel.province != null &&
        shippingInformationModel.district != null &&
        shippingInformationModel.ward != null;
  }

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      buttonText: "save",
      onTap: () {
        if (isFormValid()) {
          AddressUtils.onChanged(
              context, shippingInformationModel, actionType, index);

          if (actionType == ActionType.add) {
            NotificationUtils.showOKDialog(
                context, "address_added_successfully");
          } else {
            NotificationUtils.showOKDialog(
                context, "address_updated_successfully");
          }
        } else {
          NotificationUtils.showSnackBar(context, "please_fill_in_all_fields");
        }
      },
    );
  }
}
