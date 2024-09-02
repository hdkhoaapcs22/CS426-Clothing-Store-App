import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations(context).of("privacy_policy")),
      ),
      body: Padding(
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
              _buildSizedBox2(context),
              Text(
                AppLocalizations(context).of("terms_and_condition"),
                style: TextStyles(context).getPrivacyPolicyTextStyle(),
              ),
              _buildSizedBox1(context),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
              _buildSizedBox1(context),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
              _buildSizedBox1(context),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
              _buildSizedBox1(context),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
              _buildSizedBox1(context),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyles(context).getPrivacyPolicyTextStyle2(),
              ),
            ],
          ),
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
