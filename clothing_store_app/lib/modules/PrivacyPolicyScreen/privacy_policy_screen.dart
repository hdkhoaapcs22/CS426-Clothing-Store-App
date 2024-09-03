import 'package:flutter/material.dart';
import "package:iconsax/iconsax.dart";
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/utils/themes.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("privacy_policy"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations(context).of("privacy_policy"),
                        style: TextStyles(context).getPrivacyPolicyTextStyle(),
                      ),
                      _buildSizedBox1(context),
                      Text(
                        AppLocalizations(context).of("privacy_policy_content"),
                        style: TextStyles(context).getPrivacyPolicyTextStyle2(),
                      ),
                      _buildSizedBox2(context),
                      Text(
                        AppLocalizations(context).of("terms_and_condition"),
                        style: TextStyles(context).getPrivacyPolicyTextStyle(),
                      ),
                      _buildSizedBox1(context),
                      Text(
                        AppLocalizations(context)
                            .of("terms_and_condition_content"),
                        style: TextStyles(context).getPrivacyPolicyTextStyle2(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizedBox1(BuildContext context) {
    return MediaQuery.of(context).size.width > 360
        ? SizedBox(height: 8)
        : SizedBox(height: 4);
  }

  Widget _buildSizedBox2(BuildContext context) {
    return MediaQuery.of(context).size.width > 360
        ? SizedBox(height: 16)
        : SizedBox(height: 8);
  }
}
