import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/ShippingAddressScreen/apply_button.dart';
import 'package:clothing_store_app/modules/ShippingAddressScreen/custom_add_address_button.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int _selectedAddressIndex = 0;

  final List<Map<String, String>> _addresses = [
    {
      'label': 'Home',
      'address': '1901 Thornridge Cir. Shiloh, Hawaii 81063',
    },
    {
      'label': 'Office',
      'address': '4517 Washington Ave. Manchester, Kentucky 39495',
    },
    {
      'label': 'Parent\'s House',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
    },
    {
      'label': 'Friend\'s House',
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of('shipping_address')),
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
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: MediaQuery.of(context).size.width > 360
                            ? EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              )
                            : EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_pin, color: Colors.brown),
                          ],
                        ),
                        title: Text(
                          _addresses[index]['label']!,
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        subtitle: Text(_addresses[index]['address']!),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            value: index,
                            groupValue: _selectedAddressIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedAddressIndex = value as int;
                              });
                            },
                            activeColor: Colors.brown,
                          ),
                        ),
                      ),
                      Divider(
                        height: 16.0,
                        indent: 16.0,
                        endIndent: 16.0,
                        thickness: 0.2,
                      ),
                    ],
                  );
                },
              ),
            ),
            MediaQuery.of(context).size.width > 360
                ? SizedBox(height: 16)
                : SizedBox(height: 8),
            CustomAddAddressButton(
              onTap: () {},
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ApplyButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
