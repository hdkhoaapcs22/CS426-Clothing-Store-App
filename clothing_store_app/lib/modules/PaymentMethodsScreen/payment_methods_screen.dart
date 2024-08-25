import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/PaymentMethodsScreen/confirm_payment_button.dart';
import 'package:flutter/material.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of('payment_methods')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations(context).of('credit_and_debit_card'),
              style: TextStyles(context).getRegularStyle(),
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 10)
                : SizedBox(height: 6),
            Card(
              child: ListTile(
                leading: Icon(Icons.credit_card, color: Colors.brown),
                title: Text(AppLocalizations(context).of('add_card')),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                onTap: () {
                  NavigationServices(context).pushAddCardScreen();
                },
              ),
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 20)
                : SizedBox(height: 10),
            Text(
              AppLocalizations(context).of('more_payment_options'),
              style: TextStyles(context).getRegularStyle(),
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 10)
                : SizedBox(height: 6),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text(AppLocalizations(context).of('paypal')),
              trailing: Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                  value: 'paypal',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  activeColor: Colors.brown,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.apple),
              title: Text(AppLocalizations(context).of('apple_pay')),
              trailing: Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                  value: 'applePay',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  activeColor: Colors.brown,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text(AppLocalizations(context).of('google_pay')),
              trailing: Transform.scale(
                scale: 1.5,
                child: Radio<String>(
                  value: 'googlePay',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  activeColor: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        child: ConfirmPaymentButton(
          onPressed: () {
            if (_selectedPaymentMethod != null) {
              NavigationServices(context).pushPaymentSuccessfulScreen();
            }
          },
        ),
      ),
    );
  }
}
