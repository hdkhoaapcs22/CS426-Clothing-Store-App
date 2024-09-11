import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class ChooseShippingScreen extends StatefulWidget {
  String _selectedShippingType;

  ChooseShippingScreen({required String selectedShippingType})
      : _selectedShippingType = selectedShippingType;
  @override
  _ChooseShippingScreenState createState() => _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  final List<Map<String, String>> _shippingType = [
    {
      'label': 'economy',
      'shippingTime': 'Estimated delivery: 5-7 business days',
    },
    {
      'label': 'regular',
      'shippingTime': 'Estimated delivery: 3-5 business days',
    },
    {
      'label': 'cargo',
      'shippingTime': 'Estimated delivery: 2-3 business days',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("choose_shipping"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _shippingType.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        leading:
                            const Icon(Icons.local_shipping, color: Colors.brown),
                        title: Text(
                          AppLocalizations(context)
                              .of(_shippingType[index]['label']!),
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        subtitle: Text(_shippingType[index]['shippingTime']!),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            value: _shippingType[index]['label'],
                            groupValue: widget._selectedShippingType,
                            onChanged: (value) {
                              setState(() {
                                widget._selectedShippingType = value as String;
                              });
                            },
                            activeColor: Colors.brown,
                          ),
                        ),
                      ),
                      _buildDivider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: CommonButton(
          onTap: () {
            Navigator.pop(context, widget._selectedShippingType);
          },
          radius: 30.0,
          backgroundColor: Colors.brown,
          buttonTextWidget: Text(
            AppLocalizations(context).of("apply"),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider({
    double height = 16.0,
    double indent = 16.0,
    double endIndent = 16.0,
    double thickness = 0.2,
  }) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      thickness: thickness,
      color: Colors.black.withOpacity(0.1),
    );
  }
}
