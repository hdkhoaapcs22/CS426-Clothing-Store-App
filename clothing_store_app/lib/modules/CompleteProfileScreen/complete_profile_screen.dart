import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_dialogs.dart';
import '../../widgets/text_field_with_header.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  int _selectedGender = -1;
  String _nameError = '';
  String _phoneError = '';
  String _genderError = '';
  final List<String> genders = ["male", "female", "none"];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
                    AppLocalizations(context).of("complete_your_profile"),
                    style: TextStyles(context).getLargerHeaderStyle(false),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      AppLocalizations(context).of("complete_your_profile_descript"),
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
                      child: Image.asset(Localfiles.defaultAvatar),
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
                  TextFieldWithHeader(
                    controller: _nameController, 
                    errorMessage: _nameError, 
                    header: AppLocalizations(context).of("name"), 
                    hintText: AppLocalizations(context).of("John Doe"),
                    isPassword: false,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations(context).of("phoneNumber"),
                          style: TextStyles(context).getLabelLargeStyle(false),
                        ),
                        const SizedBox(height: 5.0,),
                        IntlPhoneField(
                          controller: _phoneController,
                          initialCountryCode: '+84',
                          disableLengthCheck: true,
                          decoration: InputDecoration(
                            error: _phoneError.isNotEmpty 
                              ? Text(
                                _phoneError,
                                style: TextStyles(context).getSmallStyle().copyWith(
                                        color: AppTheme.redErrorColor,),
                                ) : null,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          AppLocalizations(context).of("gender"),
                          style: TextStyles(context).getLabelLargeStyle(false),),
                      ),
                      DropdownButtonFormField(
                        value: null,
                        hint: Text(
                          AppLocalizations(context).of("select"), 
                          style: TextStyles(context).getLabelLargeStyle(true),),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16.0),
                          error: 
                          _genderError.isNotEmpty ? Text(
                            _genderError,
                            style: TextStyles(context).getSmallStyle().copyWith(
                                  color: AppTheme.redErrorColor,
                                ),
                          ) : null ,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.0))
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                ],
              ),
              const SizedBox(height: 16.0),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_validateAndSubmit(context)){
                    //MOVE TO LOCATION PAGE
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.brownButtonColor,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      AppLocalizations(context).of("complete_profile"),
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

  bool _isNameValid(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(name);
  }

  bool _validateAndSubmit(BuildContext context) {
    setState(() {
      _nameError = '';
      _phoneError = '';
      _genderError = '';
    });

    bool isValid = true;

    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = AppLocalizations(context).of("name_is_required");
        isValid = false;
      });
    } else if (!_isNameValid(_nameController.text)) {
      setState(() {
        _nameError = AppLocalizations(context).of("name_contains_characters");
        isValid = false;
      });
    }

    if (_phoneController.text.isEmpty) {
      setState(() {
        _phoneError = AppLocalizations(context).of("phone_number_is_required");
        isValid = false;
      });
    }

    if (_selectedGender == -1) {
      setState(() {
        _genderError = AppLocalizations(context).of("gender_is_required");
        isValid = false;
      });
    }

    if (isValid){
      Dialogs(context).showAnimatedDialog(title: AppLocalizations(context).of("complete_your_profile"), content: 'Successfully complete your profile!');
    }

    return isValid;
  }
}