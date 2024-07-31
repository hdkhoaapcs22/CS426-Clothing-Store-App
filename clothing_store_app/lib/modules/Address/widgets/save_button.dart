import 'package:flutter/material.dart';
import '../../../providers/address_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/notification_utils.dart';
import '../../../widgets/common_button.dart';
import '../../../utils/address_utils.dart';

class SaveButton extends StatelessWidget {
  final AddressModel addressModel;
  final ActionType actionType;
  final int? index;

  const SaveButton({
    Key? key,
    required this.addressModel,
    required this.actionType,
    this.index,
  }) : super(key: key);

  bool isFormValid() {
    return addressModel.fullNameController!.text.isNotEmpty &&
        addressModel.phoneNumberController!.text.isNotEmpty &&
        addressModel.addressController!.text.isNotEmpty &&
        addressModel.province != null &&
        addressModel.district != null &&
        addressModel.ward != null;
  }

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      buttonText: "save",
      onTap: () {
        if (isFormValid()) {
          AddressUtils.onChanged(context, addressModel, actionType, index);

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
