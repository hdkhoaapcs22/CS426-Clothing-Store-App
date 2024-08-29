import 'package:clothing_store_app/common/helper_funtion.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Home/custom_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';
import '../Profile/profile_service_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> accountSettingServices = [
    'password_manager',
    'delete_account',
  ];

  bool isInDarkMode = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Iconsax.tick_circle);
      }
      return const Icon(Iconsax.close_circle);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: 'Settings',
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16.0,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CustomCircleButton(
                          icon: Iconsax.user_tag,
                          backgroundColor: AppTheme.brownButtonColor,
                          radius: 20,
                      ),
                      const SizedBox(width: 16.0,),
                      Text(
                        'Account Setting',
                        style: TextStyles(context)
                            .getLabelLargeStyle(false)
                            .copyWith(
                                fontSize: 18, color: AppTheme.brownButtonColor),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: accountSettingServices.length,
                    itemBuilder: (context, index) {
                      return ProfileServiceCard(
                        icon: HelperFunction.getIconForSettingServices(index),
                        title: accountSettingServices[index],
                        onClick: () {},
                        isLastService:
                            index == accountSettingServices.length - 1,
                      );
                    })
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CustomCircleButton(
                          icon: Iconsax.setting_34,
                          backgroundColor: AppTheme.brownButtonColor,
                          radius: 20,
                      ),
                      const SizedBox(width: 16.0,),
                      Text(
                        'Other Setting',
                        style: TextStyles(context)
                            .getLabelLargeStyle(false)
                            .copyWith(
                                fontSize: 18, color: AppTheme.brownButtonColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.sun_1, color: AppTheme.brownButtonColor,),
                          const SizedBox(width: 8.0,),
                          Text(
                            AppLocalizations(context).of("dark_mode"),
                            style: TextStyles(context)
                                .getLabelLargeStyle(false)
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      Switch(
                        thumbIcon: thumbIcon,
                        value: isInDarkMode, 
                        activeColor: AppTheme.brownButtonColor,
                        onChanged: (value) {
                          setState(() {
                              isInDarkMode = value;
                            });
                        }
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  color: AppTheme.secondaryTextColor.withAlpha(100),
                ),
                Text(
                  AppLocalizations(context).of("language"),
                  style: TextStyles(context)
                      .getLabelLargeStyle(false)
                      .copyWith(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}