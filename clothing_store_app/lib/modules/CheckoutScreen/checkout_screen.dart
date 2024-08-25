import 'package:clothing_store_app/modules/CheckoutScreen/change_button.dart';
import 'package:clothing_store_app/modules/CheckoutScreen/continue_to_payment_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class CheckoutScreen extends StatelessWidget {
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
            Divider(
              height: 16.0,
              indent: 16.0,
              endIndent: 16.0,
              thickness: 0.2,
            ),
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
            Divider(
              height: 16.0,
              indent: 16.0,
              endIndent: 16.0,
              thickness: 0.2,
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 16)
                : SizedBox(height: 8),
            Text(
              AppLocalizations(context).of('order_list'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  OrderItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Brown Jacket',
                    size: 'XL',
                    price: 83.97,
                  ),
                  OrderItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Brown Suite',
                    size: 'XL',
                    price: 120.00,
                  ),
                  OrderItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Brown Jacket',
                    size: 'XL',
                    price: 83.97,
                  ),
                ],
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

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final double price;

  OrderItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Size: $size'),
          MediaQuery.of(context).size.width > 360
              ? SizedBox(height: 10)
              : SizedBox(height: 6),
          Text(
            '\$$price',
            style: TextStyles(context).getRegularStyle(),
          ),
        ],
      ),
    );
  }
}
