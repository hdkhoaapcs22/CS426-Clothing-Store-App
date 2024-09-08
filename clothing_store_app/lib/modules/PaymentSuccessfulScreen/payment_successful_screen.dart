import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../widgets/common_button.dart';
import 'package:flutter/material.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonDetailedAppBarView(
            title: AppLocalizations(context).of("payment"),
            prefixIconData: Iconsax.arrow_left,
            onPrefixIconClick: () {
              NavigationServices(context).popToHomeScreen();
            },
            iconColor: AppTheme.primaryTextColor,
            backgroundColor: AppTheme.backgroundColor,
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: MediaQuery.of(context).size.width > 360
                    ? const EdgeInsets.all(32.0)
                    : const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.brown,
                      size: MediaQuery.of(context).size.width > 360 ? 100 : 80,
                    ),
                    MediaQuery.of(context).size.width > 360
                        ? SizedBox(height: 20)
                        : SizedBox(height: 10),
                    Text(
                      AppLocalizations(context).of('payment_successful'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MediaQuery.of(context).size.width > 360
                        ? SizedBox(height: 20)
                        : SizedBox(height: 10),
                    Text(
                      AppLocalizations(context)
                          .of('thank_you_for_your_purchase'),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    MediaQuery.of(context).size.width > 360
                        ? SizedBox(height: 20)
                        : SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(32.0)
            : const EdgeInsets.all(16.0),
        child: CommonButton(
          onTap: () {
            NavigationServices(context).popToMyOrder();
          },
          radius: 30.0,
          backgroundColor: AppTheme.brownButtonColor,
          buttonTextWidget: Text(
            AppLocalizations(context).of("view_order"),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }
}
