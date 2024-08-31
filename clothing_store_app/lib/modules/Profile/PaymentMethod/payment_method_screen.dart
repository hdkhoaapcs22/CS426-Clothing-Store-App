import 'package:clothing_store_app/modules/Profile/PaymentMethod/payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../languages/appLocalizations.dart';
import '../../../utils/localfiles.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';
import '../../../widgets/common_detailed_app_bar.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("payment_methods"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations(context).of("credit_and_debit_card"),
                    style: TextStyles(context)
                        .getLabelLargeStyle(false)
                        .copyWith(
                            fontSize: 18, color: AppTheme.brownButtonColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PaymentMethodWidget(
                      content: 'Add New Card',
                      icon: Iconsax.card5,
                      onClick: () {}),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  Text(
                    AppLocalizations(context).of("more_payment_options"),
                    style: TextStyles(context)
                        .getLabelLargeStyle(false)
                        .copyWith(
                            fontSize: 18, color: AppTheme.brownButtonColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PaymentMethodWidget(
                      content: 'Paypal',
                      image: Localfiles.paypalIcon,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      onClick: () {}),
                  PaymentMethodWidget(
                      content: 'Apple Pay',
                      image: Localfiles.appleIcon,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      onClick: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
