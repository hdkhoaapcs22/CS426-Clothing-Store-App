import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/shipping_information.dart';

class ShippingInformationModel extends ChangeNotifier {
  String? _province, _district, _ward;
  TextEditingController? _fullNameController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;

  ShippingInformationModel() {
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();

    _phoneNumberController!.addListener(_phoneValidator);
  }

  @override
  void dispose() {
    _phoneNumberController!.removeListener(_phoneValidator);
    _fullNameController!.dispose();
    _phoneNumberController!.dispose();
    _addressController!.dispose();
    super.dispose();
  }

  String? get province => _province;

  set province(String? value) {
    if (_province != value) {
      _province = value;
      notifyListeners();
    }
  }

  String? get district => _district;

  set district(String? value) {
    if (_district != value) {
      _district = value;
      notifyListeners();
    }
  }

  String? get ward => _ward;

  set ward(String? value) {
    if (_ward != value) {
      _ward = value;
      notifyListeners();
    }
  }

  String? get province_district =>
      _province != null && _district != null ? '$_district, $_province' : null;

  TextEditingController? get fullNameController => _fullNameController;
  TextEditingController? get phoneNumberController => _phoneNumberController;
  TextEditingController? get addressController => _addressController;

  void _phoneValidator() {
    if (_phoneNumberController!.text.length > 10) {
      _phoneNumberController!.text =
          _phoneNumberController!.text.substring(0, 10);
    }
  }

  void setAddress(ShippingInformation address) {
    _province = address.city;
    _district = address.district;
    _ward = address.ward;
    _fullNameController!.text = address.name;
    _phoneNumberController!.text = address.phoneNumber;
    _addressController!.text = address.street;
  }

  @override
  String toString() {
    String _fullName = _fullNameController!.text;
    String _phoneNumber = _phoneNumberController!.text;
    String _address = _addressController!.text;

    return '$_fullName, $_phoneNumber, $_address, $_ward, $_district, $_province';
  }

  void clear() {
    _province = null;
    _district = null;
    _ward = null;
    _fullNameController!.clear();
    _phoneNumberController!.clear();
    _addressController!.clear();

    notifyListeners();
  }
}
