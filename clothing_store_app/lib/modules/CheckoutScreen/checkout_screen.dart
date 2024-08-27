import 'package:clothing_store_app/modules/CheckoutScreen/change_button.dart';
import 'package:clothing_store_app/modules/CheckoutScreen/continue_to_payment_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import '../../class/order.dart';
import 'order_item_view.dart';
import 'divider.dart';

class CheckoutScreen extends StatefulWidget {
  final Order order;

  CheckoutScreen({required this.order});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
        title: Text(AppLocalizations(context).of('checkout')),
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations(context).of('shipping_address'),
              style: TextStyles(context).getRegularStyle(),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(AppLocalizations(context).of('home')),
              subtitle: Text('1901 Thornridge Cir. Shiloh, Hawaii 81063'),
              trailing: ChangeButton(
                onPressed: () {
                  NavigationServices(context).pushShippingAddressScreen();
                },
              ),
            ),
            CustomDivider(),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 16)
                : SizedBox(height: 8),
            Text(
              AppLocalizations(context).of('choose_shipping_type'),
              style: TextStyles(context).getRegularStyle(),
            ),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text(AppLocalizations(context).of('economy')),
              subtitle: Text('Estimated Arrival 25 August 2023'),
              trailing: ChangeButton(
                onPressed: () {
                  NavigationServices(context).pushChooseShippingScreen();
                },
              ),
            ),
            CustomDivider(),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 16)
                : SizedBox(height: 8),
            Text(
              AppLocalizations(context).of('order_list'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: widget.order.clothesSold.map((item) {
                  return OrderItemView(
                    imageUrl: item['imageURL'],
                    title: item['name'],
                    size: item['size'],
                    price: item['price'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ContinueToPaymentButton(
          onPressed: () {
            NavigationServices(context).pushPaymentMethodsScreen();
          },
        ),
      ),
    );
  }
}
