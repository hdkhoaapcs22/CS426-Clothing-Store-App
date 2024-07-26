import 'package:flutter/material.dart';

class AddressModel with ChangeNotifier {
  String? _selectedProvinceCode;
  String? _selectedDistrictCode;
  String? _selectedWardCode;
  String? _selectedProvinceName;
  String? _selectedDistrictName;
  String? _selectedWardName;
  String? _name;
  String? _phone;
  String? _address;

  // AddressModel({
  //   required String? name, 
  //   required String? phone, 
  //   required String? address
  // }) {
  //   _name = name;
  //   _phone = phone;
  //   // 436A Dinh Bo Linh, Ward 26, Binh Thanh District, Ho Chi Minh City
  //   List<String> parts = address?.split(", ") ?? [];
  //   if (parts.length == 4) {
  //     _address = parts[0];
  //     _selectedWardName = parts[1];
  //     _selectedDistrictName = parts[2];
  //     _selectedProvinceName = parts[3];
  //   }
  // }

  String? get selectedProvinceCode => _selectedProvinceCode;
  String? get selectedDistrictCode => _selectedDistrictCode;
  String? get selectedWardCode => _selectedWardCode;
  String? get selectedProvinceName => _selectedProvinceName;
  String? get selectedDistrictName => _selectedDistrictName;
  String? get selectedWardName => _selectedWardName;
  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setSelectedProvinceName(String? name) {
    _selectedProvinceName = name;
    notifyListeners();
  }

  void setSelectedDistrictName(String? name) {
    _selectedDistrictName = name;
    notifyListeners();
  }

  void setSelectedWardName(String? name) {
    _selectedWardName = name;
    notifyListeners();
  }

  void setSelectedProvinceCode(String? code) {
    _selectedProvinceCode = code;
    _selectedDistrictCode = null; // Reset district and ward when province changes
    _selectedWardCode = null;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void setSelectedDistrictCode(String? code) {
    _selectedDistrictCode = code;
    _selectedWardCode = null; // Reset ward when district changes
    notifyListeners();
  }

  void setSelectedWardCode(String? code) {
    _selectedWardCode = code;
    notifyListeners();
  }
}
