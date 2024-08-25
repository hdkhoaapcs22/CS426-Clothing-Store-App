import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/ChooseShippingScreen/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';

class ChooseShippingScreen extends StatefulWidget {
  const ChooseShippingScreen({Key? key}) : super(key: key);

  @override
  _ChooseShippingScreenState createState() => _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  int _selectedAddressIndex = 0;

  final List<Map<String, String>> _addresses = [
    {
      'label': 'Economy',
      'address': 'Estimated delivery: 5-7 business days',
    },
    {
      'label': 'Regular',
      'address': 'Estimated delivery: 3-5 business days',
    },
    {
      'label': 'Cargo',
      'address': 'Estimated delivery: 2-3 business days',
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
        title: Text(AppLocalizations(context).of('choose_shipping')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
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
                            Icon(Icons.local_shipping, color: Colors.brown),
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
