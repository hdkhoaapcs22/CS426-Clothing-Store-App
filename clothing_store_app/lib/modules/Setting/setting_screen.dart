import 'package:clothing_store_app/common/helper_funtion.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Home/custom_circle_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
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

  final List<String> languages = [
    'english', 'french'
  ];
  String _selectedLanguage = 'english';

  late bool isInLightMode;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Iconsax.tick_circle);
      }
      return const Icon(Iconsax.close_circle);
    },
  );

  late ThemeProvider themeProvider;

  @override
  void initState(){
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    isInLightMode = themeProvider.isLightMode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("settings"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            const SizedBox(height: 16.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  CustomCircleButton(
                      icon: Iconsax.user_tag,
                      backgroundColor: AppTheme.brownButtonColor,
                      radius: 20,
                  ),
                  const SizedBox(width: 16.0,),
                  Text(
                    AppLocalizations(context).of("account_setting"),
                    style: TextStyles(context)
                        .getLabelLargeStyle(false)
                        .copyWith(
                            fontSize: 18, color: AppTheme.brownButtonColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: accountSettingServices.length,
                itemBuilder: (context, index) {
                  return ProfileServiceCard(
                    icon: HelperFunction.getIconForSettingServices(index),
                    title: accountSettingServices[index],
                    onClick: getSettingServicesFunction(context, index),
                    isLastService:
                        index == accountSettingServices.length - 1,
                  );
                }),
            SizedBox(height: MediaQuery.of(context).size.height / 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  CustomCircleButton(
                      icon: Iconsax.setting_34,
                      backgroundColor: AppTheme.brownButtonColor,
                      radius: 20,
                  ),
                  const SizedBox(width: 16.0,),
                  Text(
                    AppLocalizations(context).of("other_setting"),
                    style: TextStyles(context)
                        .getLabelLargeStyle(false)
                        .copyWith(
                            fontSize: 18, color: AppTheme.brownButtonColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),
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
                      value: !isInLightMode,
                      activeColor: AppTheme.brownButtonColor,
                      onChanged: (value) {
                        isInLightMode = value;
                        ThemeModeType type =
                            value ? ThemeModeType.dark : ThemeModeType.light;
                        themeProvider.updateThemeMode(type);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.language_square,
                        color: AppTheme.brownButtonColor,
                      ),
                      const SizedBox(width: 8.0,),
                      Text(
                        AppLocalizations(context).of("language"),
                        style: TextStyles(context)
                            .getLabelLargeStyle(false)
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: AppTheme.brownButtonColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton(
                        value: _selectedLanguage,
                        items: languages.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                    AppLocalizations(context).of(item),
                                    style: TextStyles(context)
                                        .getLabelLargeStyle(false),
                                  ),
                              ),
                          ); 
                        }).toList(),
                        onChanged: (String? value) {
                          LanguageType tmp;
                          value! == 'english' ? tmp = LanguageType.en : tmp = LanguageType.fr;
                           _selectedLanguage = value;
                          context.read<ThemeProvider>().updateLanguage(tmp);
                        },
                        icon: Icon(Iconsax.arrow_down_1, color: AppTheme.brownButtonColor,),
                        alignment: AlignmentDirectional.bottomCenter,
                        underline: Container()
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

VoidCallback getSettingServicesFunction(BuildContext context, int index) {
  switch (index) {
    case 0:
      return () {
        NavigationServices(context).pushPasswordManagerScreen();
      };
    case 1:
      return () async {
        await deleteAccountBottomSheet(context);
      };
    default:
      return () {};
  }
}

Future<dynamic> deleteAccountBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context, 
    builder: (context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  AppLocalizations(context).of("delete_account"),
                  style: TextStyles(context)
                      .getLabelLargeStyle(false)
                      .copyWith(fontSize: 18),
                ),
            ),
            Divider(
              indent: 32,
              endIndent: 32,
              thickness: 0.5,
              color: AppTheme.secondaryTextColor.withAlpha(200),
            ),
            Text(
                AppLocalizations(context).of("are_you_sure_to_delete_account"),
                style:
                    TextStyles(context).getInterDescriptionStyle(false, false),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppTheme.backgroundColor,
                      buttonText: "cancel",
                      textColor: AppTheme.brownButtonColor,
                      bordeColor: AppTheme.brownButtonColor,
                      fontSize: 16,
                      radius: 30,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppTheme.brownButtonColor,
                      buttonText: "yes_delete",
                      textColor: AppTheme.backgroundColor,
                      fontSize: 16,
                      radius: 30,
                      onTap: () {
                        final auth = AuthService();
                        auth.deleteAccount(context);
                      },
                    )
                  )
                ],
              ),
            )
          ],),
      );
    }
  );
}