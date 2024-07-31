import 'package:flutter/material.dart';

import '../languages/appLocalizations.dart';
import '../providers/address_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AddressModel addressModel;
  final String title;
  final Function()? onPressed;

  const CustomAppBar({
    Key? key,
    required this.addressModel,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations(context).of(title)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
