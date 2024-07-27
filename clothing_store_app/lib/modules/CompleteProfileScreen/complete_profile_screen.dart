import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_textfield.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<String> genders = ["male", "female", "none"];
  int _selectedGender = -1;
  String _nameError = '';
  String _phoneError = '';
  String _genderError = '';

  bool _isNameValid(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name);
  }

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      _nameError = '';
      _phoneError = '';
      _genderError = '';
    });

    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
    } else if (!_isNameValid(_nameController.text)) {
      setState(() {
        _nameError = 'Name should not contain special characters or numbers';
      });
    }

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneError = 'Phone number is required';
      });
    }

    if (_selectedGender == -1) {
      setState(() {
        _genderError = 'Please select a gender';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              elevation: 0,
              shape: const CircleBorder(),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(0.0),
            ),
            child: const Icon(Iconsax.arrow_left),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations(context).of("completeYourProfile"),
                    style: TextStyles(context).getLargerHeaderStyle(false),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      AppLocalizations(context).of("completeYourProfileDescript"),
                      style: TextStyles(context).getInterDescriptionStyle(false, false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: Image.asset('assets/images/default_avatar.png'),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          //get image from library
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.brown,
                          ),
                          child: const Icon(Iconsax.image, color: Colors.white, size: 20,)
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10.0,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations(context).of("name"), style: TextStyles(context).getLabelLargeStyle(false),),
                        const SizedBox(height: 5.0,),
                        CommonTextField(
                          textEditingController: _nameController,
                          contentPadding: const EdgeInsets.all(16.0),
                          hintTextStyle: TextStyles(context).getLabelLargeStyle(true),
                          hintText: AppLocalizations(context).of("John Doe"),
                          focusColor: Colors.brown,
                          textFieldPadding: const EdgeInsets.all(0.0),
                          errorText: _nameError,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations(context).of("phoneNumber"),
                          style: TextStyles(context).getLabelLargeStyle(false),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        IntlPhoneField(
                          controller: _phoneController,
                          initialCountryCode: '+84',
                          disableLengthCheck: true,
                          decoration: InputDecoration(
                            error: 
                            _phoneError.isNotEmpty ? Padding(
                                padding: const EdgeInsets.only(top: 5, left: 8),
                                child: Text(
                                  _phoneError ?? "",
                                  style: TextStyles(context)
                                      .getSmallStyle()
                                      .copyWith(
                                        color: AppTheme.redErrorColor,
                                      ),
                                ),
                              ) : null ,
                            hintText: AppLocalizations(context).of("enterPhoneNumber"),
                            hintStyle: TextStyles(context).getLabelLargeStyle(true),
                            contentPadding: const EdgeInsets.all(16.0),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40.0))
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations(context).of("gender"),
                          style: TextStyles(context).getLabelLargeStyle(false),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        DropdownButtonFormField(
                          value: null,
                          hint: Text(AppLocalizations(context).of("select"), style: TextStyles(context).getLabelLargeStyle(true),),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            error: 
                            _genderError.isNotEmpty ? Padding(
                                padding: const EdgeInsets.only(top: 5, left: 8),
                                child: Text(
                                  _genderError ?? "",
                                  style: TextStyles(context)
                                      .getSmallStyle()
                                      .copyWith(
                                        color: AppTheme.redErrorColor,
                                      ),
                                ),
                              ) : null ,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40.0))
                            ),
                          ),
                          items: List<DropdownMenuItem<int>>.generate(
                            genders.length, 
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(
                                AppLocalizations(context).of(genders[index]),
                                style: TextStyles(context).getLabelLargeStyle(false),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            _selectedGender = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  //MOVE TO LOCATION PAGE
                  _validateAndSubmit(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brownButtonColor,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      AppLocalizations(context).of("completeProfile"),
                      style: TextStyles(context).getButtonTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}