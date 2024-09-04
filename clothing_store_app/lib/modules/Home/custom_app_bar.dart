import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:clothing_store_app/class/notification_info.dart';
import 'package:lottie/lottie.dart';

import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../widgets/tap_effect.dart';

class CustomAppBar extends StatefulWidget {
  final double? topPadding;

  const CustomAppBar({super.key, this.topPadding});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> addresses = [
    'New York, USA',
  ];

  String _selectedAddress = 'New York, USA';

  @override
  Widget build(BuildContext context) {
    final double tmp = widget.topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: tmp),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder(
          stream: UserInformationService().getUserInfomationStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.data() != null) {
              var userData = snapshot.data!.data()!;
              List<Map<String, dynamic>> notificationMap =
                  List<Map<String, dynamic>>.from(userData['notifications']);
              List<NotificationInfo> notifications = notificationMap
                  .map((map) => NotificationInfo.fromMap(map))
                  .toList();
              int nonReadCount = notifications
                  .where((notification) => !notification.isRead)
                  .length;

              var defaultAddress = userData['defaultShippingInfo'];

              List<String> addressParts = defaultAddress.split(', ');

              if (addressParts.length < 3) {
                return const SizedBox.shrink();
              }

              String address = addressParts[2].trim();
              bool hasDefaultAddress =
                  defaultAddress != null && defaultAddress.isNotEmpty;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations(context).of("location"),
                        style: TextStyles(context)
                            .getLabelLargeStyle(true)
                            .copyWith(fontSize: 11),
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location5,
                            size: 20,
                            color: AppTheme.brownColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              hasDefaultAddress
                                  ? address
                                  : AppLocalizations(context)
                                      .of("please_select_your_location"),
                              style: TextStyles(context)
                                  .getLabelLargeStyle(false)
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TapEffect(
                    onClick: () {
                      NavigationServices(context).pushNotificationScreen();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppTheme.greyBackgroundColor,
                      child: nonReadCount > 0
                          ? Badge(
                              label: Text(nonReadCount.toString()),
                              child: Icon(
                                Iconsax.notification,
                                color: AppTheme.primaryTextColor,
                              ),
                            )
                          : Icon(
                              Iconsax.notification,
                              color: AppTheme.primaryTextColor,
                            ),
                    ),
                  ),
                ],
              );
            }

            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            );
          },
        ),
      ),
    );
  }
}
