import 'package:clothing_store_app/utils/notification_utils.dart';
import 'package:flutter/material.dart';

import '../../../providers/address_model.dart';
import '../../../utils/address_utils.dart';
import '../../../utils/enum.dart';
import '../../../widgets/common_button.dart';

class DeleteButton extends StatelessWidget {
  final AddressModel addressModel;
  final int index;

  const DeleteButton({
    Key? key,
    required this.addressModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      buttonText: "delete",
      onTap: () {
        NotificationUtils.showTwoOptionsDialog(
          context,
          "are_you_sure_you_want_to_delete_this_address",
          "cancel",
          "delete", 
          () {
            AddressUtils.onChanged(context, addressModel, ActionType.delete, index);
            NotificationUtils.showOKDialog(context, "address_deleted_successfully");
          },
        );
      },
    );
  }
}
