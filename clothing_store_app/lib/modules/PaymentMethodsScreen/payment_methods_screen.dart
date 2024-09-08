import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/services/database/cart.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:clothing_store_app/utils/enum.dart';
import 'package:flutter/material.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';
import '../../class/order_info.dart';
import '../../widgets/common_button.dart';
import '../../utils/themes.dart';
import 'package:lottie/lottie.dart';
import '../../utils/localfiles.dart';
import 'package:intl/intl.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class PaymentMethodsScreen extends StatefulWidget {
  OrderInfo order;

  PaymentMethodsScreen({required this.order});

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = "paypal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
            Text(
              AppLocalizations(context).of('credit_and_debit_card'),
              style: TextStyles(context)
                  .getLabelLargeStyle(false)
                  .copyWith(fontSize: 18, color: AppTheme.brownButtonColor),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            StreamBuilder(
              stream: UserInformationService().getUserInfomationStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset(
                        Localfiles.loading,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ));
                } else if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return const Center(child: Text('User data not found'));
                }

                var userData = snapshot.data!.data()!;

                String? cardNumber = userData['cardNumber'];

                if (cardNumber == null || cardNumber.isEmpty) {
                  return _buildPaymentMethodTile(
                      context: context,
                      content: AppLocalizations(context).of('add_card'),
                      value: 'credit_card',
                      icon: Icons.credit_card,
                      hasCardNum: true,
                      onTap: () {
                        NavigationServices(context).pushAddCardScreen();
                      });
                } else {
                  return Dismissible(
                    key: Key('credit_card'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _selectedPaymentMethod = "paypal";
                      });
                      UserInformationService().deleteCardNumber();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Credit card deleted')),
                      );
                    },
                    child: _buildPaymentMethodTile(
                        context: context,
                        content: cardNumber,
                        icon: Icons.credit_card,
                        value: 'credit_card'),
                  );
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              AppLocalizations(context).of('more_payment_options'),
              style: TextStyles(context)
                  .getLabelLargeStyle(false)
                  .copyWith(fontSize: 18, color: AppTheme.brownButtonColor),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildPaymentMethodTile(
              context: context,
              content: 'Paypal',
              value: 'paypal',
              image: Localfiles.paypalIcon,
            ),
            _buildPaymentMethodTile(
              context: context,
              content: 'Apple Pay',
              value: 'applePay',
              image: Localfiles.appleIcon,
            ),
            _buildPaymentMethodTile(
              context: context,
              content: 'Google Pay',
              value: 'googlePay',
              image: Localfiles.googleIcon,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: CommonButton(
          onTap: () async {
            await CartService().moveItemsToActiveOrder(order: widget.order);

            String formattedTime =
                DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.now());

            await UserInformationService().addNotification({
              'type': NotificationType.orderShipped.index,
              'title': 'Order Shipped',
              'time': formattedTime,
              'description':
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              'isRead': false,
            });

            NavigationServices(context).pushPaymentSuccessfulScreen();
          },
          radius: 30.0,
          backgroundColor: AppTheme.brownButtonColor,
          buttonTextWidget: Text(
            AppLocalizations(context).of("confirm_payment"),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required BuildContext context,
    required String content,
    required String value,
    IconData? icon,
    String? image,
    BorderRadiusGeometry? borderRadius,
    bool hasCardNum = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          border: Border.all(color: AppTheme.greyBackgroundColor),
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon != null
                      ? Icon(
                          icon,
                          color: AppTheme.brownButtonColor,
                        )
                      : CircleAvatar(
                          radius: 10,
                          backgroundColor: AppTheme.backgroundColor,
                          child: Image(
                            image: AssetImage(image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    content,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              hasCardNum == false
                  ? Transform.scale(
                      scale: 1.5,
                      child: Radio<String>(
                        value: value,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                    )
                  : const Icon(Icons.arrow_forward_ios, color: Colors.brown),
            ],
          ),
        ),
      ),
    );
  }
}
