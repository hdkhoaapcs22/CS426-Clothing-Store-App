import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import '../../widgets/common_button.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import 'package:clothing_store_app/widgets/common_app_bar_view.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cardNumberController;
  bool _saveCard = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 5,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonAppBarView(
                    topPadding: 0,
                    iconData: Icons.arrow_back,
                    onBackClick: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppLocalizations(context).of('add_card'),
                        style: TextStyles(context).getTitleStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.05),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations(context).of('card_number'),
                                    style: TextStyles(context)
                                        .getCreditCardTextStyle(),
                                  ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Text(
                                AppLocalizations(context)
                                    .of('card_holder_name'),
                                style: TextStyles(context)
                                    .getCreditCardTextStyle2(),
                              ),
                              Text(
                                AppLocalizations(context)
                                    .of('card_holder_name'),
                                style: TextStyles(context)
                                    .getCreditCardTextStyle3(),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations(context).of('expiry_date'),
                                    style: TextStyles(context)
                                        .getCreditCardTextStyle2(),
                                  ),
                                  Text(
                                    AppLocalizations(context).of('cvv'),
                                    style: TextStyles(context)
                                        .getCreditCardTextStyle2(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations(context).of('expiry_date'),
                                    style: TextStyles(context)
                                        .getCreditCardTextStyle3(),
                                  ),
                                  Text(
                                    AppLocalizations(context).of('cvv'),
                                    style: TextStyles(context)
                                        .getCreditCardTextStyle3(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations(context).of('card_holder_name'),
                          labelStyle: TextStyle(
                            color: AppTheme.brownButtonColor,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppTheme.brownButtonColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter card holder name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextFormField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations(context).of('card_number'),
                          labelStyle: TextStyle(
                            color: AppTheme.brownButtonColor,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppTheme.brownButtonColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter card number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations(context).of('expiry_date'),
                                labelStyle: TextStyle(
                                  color: AppTheme.brownButtonColor,
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: AppTheme.brownButtonColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter expiry date';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: AppLocalizations(context).of('cvv'),
                                labelStyle: TextStyle(
                                  color: AppTheme.brownButtonColor,
                                ),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: AppTheme.brownButtonColor,
                                  ),
                                ),
                              ),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: CommonButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context);
              UserInformationService()
                  .addCardNumber(_cardNumberController.text);
            }
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
