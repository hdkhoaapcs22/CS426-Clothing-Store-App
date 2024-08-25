import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../widgets/common_button.dart';
import '../../routes/navigation_services.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of('add_card')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).size.width > 360
              ? const EdgeInsets.all(16.0)
              : const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: MediaQuery.of(context).size.width > 360
                        ? const EdgeInsets.all(16.0)
                        : const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.brown[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '4716 9627 1635 8047',
                              style:
                                  TextStyles(context).getCreditCardTextStyle(),
                            ),
                            Image.asset(
                              'assets/images/logo.png',
                              width: MediaQuery.of(context).size.width > 360
                                  ? 50
                                  : 30,
                              height: MediaQuery.of(context).size.width > 360
                                  ? 50
                                  : 30,
                            ),
                          ],
                        ),
                        MediaQuery.of(context).size.width > 360
                            ? SizedBox(height: 10)
                            : SizedBox(height: 6),
                        Text(
                          AppLocalizations(context).of('card_holder_name'),
                          style: TextStyles(context).getCreditCardTextStyle2(),
                        ),
                        Text(
                          'Esther Howard',
                          style: TextStyles(context).getCreditCardTextStyle3(),
                        ),
                        MediaQuery.of(context).size.width > 360
                            ? SizedBox(height: 10)
                            : SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations(context).of('expiry_date'),
                              style:
                                  TextStyles(context).getCreditCardTextStyle2(),
                            ),
                            MediaQuery.of(context).size.width > 360
                                ? SizedBox(height: 20)
                                : SizedBox(height: 10),
                            Text(
                              AppLocalizations(context).of('cvv'),
                              style:
                                  TextStyles(context).getCreditCardTextStyle2(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '02/30',
                              style:
                                  TextStyles(context).getCreditCardTextStyle3(),
                            ),
                            MediaQuery.of(context).size.width > 360
                                ? SizedBox(height: 20)
                                : SizedBox(height: 10),
                            Text(
                              '000',
                              style:
                                  TextStyles(context).getCreditCardTextStyle3(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                MediaQuery.of(context).size.width > 360
                    ? SizedBox(height: 20)
                    : SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations(context).of('card_holder_name'),
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'Esther Howard',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card holder name';
                    }
                    return null;
                  },
                ),
                MediaQuery.of(context).size.width > 360
                    ? SizedBox(height: 20)
                    : SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations(context).of('card_number'),
                    border: OutlineInputBorder(),
                  ),
                  initialValue: '4716 9627 1635 8047',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    return null;
                  },
                ),
                MediaQuery.of(context).size.width > 360
                    ? SizedBox(height: 20)
                    : SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations(context).of('expiry_date'),
                          border: OutlineInputBorder(),
                        ),
                        initialValue: '02/30',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          return null;
                        },
                      ),
                    ),
                    MediaQuery.of(context).size.width > 360
                        ? SizedBox(width: 20)
                        : SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations(context).of('cvv'),
                          border: OutlineInputBorder(),
                        ),
                        initialValue: '000',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                MediaQuery.of(context).size.width > 360
                    ? SizedBox(height: 20)
                    : SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _saveCard,
                      activeColor: AppTheme.brownButtonColor,
                      onChanged: (bool? value) {
                        setState(() {
                          _saveCard = value ?? false;
                        });
                      },
                    ),
                    Text(AppLocalizations(context).of('save_card')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).size.width > 360
            ? const EdgeInsets.all(32.0)
            : const EdgeInsets.all(16.0),
        child: CommonButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {}
          },
          radius: 30.0,
          backgroundColor: AppTheme.brownButtonColor,
          buttonTextWidget: Text(
            AppLocalizations(context).of("add_card"),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }
}
