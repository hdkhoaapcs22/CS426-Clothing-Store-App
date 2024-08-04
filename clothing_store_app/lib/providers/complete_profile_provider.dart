import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart'; // Adjust the import as necessary

class CompleteProfileNotifier extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int _selectedGender = -1;
  String _genderError = '';
  String _nameError = '';
  String _phoneError = '';
  final List<String> genders = ["male", "female", "none"];

  int get selectedGender => _selectedGender;
  String get genderError => _genderError;
  String get nameError => _nameError;
  String get phoneError => _phoneError;

  void setSelectedGender(int gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setName(String name) {
    nameController.text = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    phoneController.text = phone;
    notifyListeners();
  }

  bool validateFields(BuildContext context) {
    _nameError = '';
    _phoneError = '';
    _genderError = '';

    if (nameController.text.isEmpty) {
      _nameError = AppLocalizations(context).of("name_is_required");
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(nameController.text)) {
      _nameError = AppLocalizations(context).of("name_contains_characters");
    }

    if (phoneController.text.isEmpty) {
      _phoneError = AppLocalizations(context).of("phone_number_is_required");
    }

    if (_selectedGender == -1) {
      _genderError = AppLocalizations(context).of("gender_is_required");
    }

    notifyListeners();
    return _nameError.isEmpty && _phoneError.isEmpty && _genderError.isEmpty;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
