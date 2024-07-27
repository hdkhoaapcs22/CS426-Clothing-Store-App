import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/common.dart';
import '../../providers/address_model.dart';
import 'package:provider/provider.dart';
import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/services.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<List<String>> _getProvinces(String query) async {
    List<String> provinces = [];
    QuerySnapshot snapshot = await firestore.collection('provinces').get();
    for (var doc in snapshot.docs) {
      provinces.add(doc['name']);
    }
    return provinces;
  }

  Future<String?> _getProvinceCode(String provinceName) async {
    QuerySnapshot snapshot = await firestore
        .collection('provinces')
        .where('name', isEqualTo: provinceName)
        .get();
    return snapshot.docs.isNotEmpty ? snapshot.docs[0]['code'] : null;
  }

  Future<List<String>> _getDistricts(String query) async {
    List<String> districts = [];
    final addressModel = Provider.of<AddressModel>(context, listen: false);
    QuerySnapshot snapshot = await firestore
        .collection('districts')
        .where('province_code', isEqualTo: addressModel.selectedProvinceCode)
        .get();
    for (var doc in snapshot.docs) {
      districts.add(doc['name']);
    }
    return districts;
  }

  Future<String?> _getDistrictCode(String districtName) async {
    QuerySnapshot snapshot = await firestore
        .collection('districts')
        .where('name', isEqualTo: districtName)
        .get();
    return snapshot.docs.isNotEmpty ? snapshot.docs[0]['code'] : null;
  }

  Future<List<String>> _getWards(String query) async {
    List<String> wards = [];
    final addressModel = Provider.of<AddressModel>(context, listen: false);
    QuerySnapshot snapshot = await firestore
        .collection('wards')
        .where('district_code', isEqualTo: addressModel.selectedDistrictCode)
        .get();
    for (var doc in snapshot.docs) {
      wards.add(doc['name']);
    }
    return wards;
  }

  Future<String?> _getWardCode(String wardName) async {
    QuerySnapshot snapshot = await firestore
        .collection('wards')
        .where('name', isEqualTo: wardName)
        .get();
    return snapshot.docs.isNotEmpty ? snapshot.docs[0]['code'] : null;
  }

  Future<void> _useCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      final addressModel = Provider.of<AddressModel>(context, listen: false);
      addressModel.setSelectedProvinceName(placemark.administrativeArea);
      addressModel.setSelectedDistrictName(placemark.subAdministrativeArea);
      addressModel.setSelectedWardName(placemark.locality);

      _initAddressCode();
    }
  }

    Future<void> _initAddressCode() async {
    final addressModel = Provider.of<AddressModel>(context, listen: false);

    String? provinceCode =
        await _getProvinceCode(addressModel.selectedProvinceName!);
    addressModel.setSelectedProvinceCode(provinceCode);

    String? districtCode =
        await _getDistrictCode(addressModel.selectedDistrictName!);
    addressModel.setSelectedDistrictCode(districtCode);

    String? wardCode = await _getWardCode(addressModel.selectedWardName!);
    addressModel.setSelectedWardCode(wardCode);
  }

  @override
  void initState() {
    super.initState();
    _useCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of("add-new-address")),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CommonTextField(
              textEditingController: nameController,
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              hintTextStyle: const TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              hintText: "name",
              textFieldPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: "phone",
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              textEditingController: addressController,
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              hintTextStyle: const TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              hintText: "address",
              textFieldPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(height: 16),
            DropdownSearch<String>(
              asyncItems: _getProvinces,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: const BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              dropdownBuilder: (context, String? item) {
                if (addressModel.selectedProvinceName == null) {
                  return Text(AppLocalizations(context).of("select-province"));
                } else {
                  return Text(addressModel.selectedProvinceName!);
                }
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getProvinceCode(value);
                  setState(() {
                    addressModel.setSelectedProvinceCode(code);
                    addressModel.setSelectedProvinceName(value);
                    addressModel.setSelectedDistrictCode(null);
                    addressModel.setSelectedDistrictName(null);
                    addressModel.setSelectedWardCode(null);
                    addressModel.setSelectedWardName(null);
                  });
                }
              },
              selectedItem: addressModel.selectedProvinceCode,
            ),
            const SizedBox(height: 16),
            DropdownSearch<String>(
              asyncItems: _getDistricts,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: const BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              dropdownBuilder: (context, String? item) {
                if (addressModel.selectedDistrictName == null) {
                  return Text(AppLocalizations(context).of("select-district"));
                } else {
                  return Text(addressModel.selectedDistrictName!);
                }
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getDistrictCode(value);
                  setState(() {
                    addressModel.setSelectedDistrictCode(code);
                    addressModel.setSelectedDistrictName(value);
                    addressModel.setSelectedWardName(null);
                    addressModel.setSelectedWardCode(null);
                  });
                }
              },
              selectedItem: addressModel.selectedDistrictCode,
            ),
            const SizedBox(height: 16),
            DropdownSearch<String>(
              asyncItems: _getWards,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: const BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              dropdownBuilder: (context, String? item) {
                if (addressModel.selectedWardName == null) {
                  return Text(AppLocalizations(context).of("select-ward"));
                } else {
                  return Text(addressModel.selectedWardName!);
                }
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getWardCode(value);
                  setState(() {
                    addressModel.setSelectedWardCode(code);
                    addressModel.setSelectedWardName(value);
                  });
                }
              },
              selectedItem: addressModel.selectedWardCode,
            ),
            const SizedBox(height: 16),
            CommonButton(
              buttonText: "save",
              onTap: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                  return;
                }

                if (addressModel.selectedProvinceCode == null ||
                    addressModel.selectedDistrictCode == null ||
                    addressModel.selectedWardCode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select province, district, ward",
                          style: TextStyle(color: Colors.red)),
                    ),
                  );
                  return;
                }

                addressModel.setName(nameController.text);
                addressModel.setPhone(phoneController.text);
                addressModel.setAddress(addressController.text);
                _updateAddress(addressModel, _autoID());
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              buttonText:
                  "use-current-location",
              onTap: _useCurrentLocation,
            ),
          ],
        ),
      ),
    );
  }

  void _updateAddress(AddressModel addressModel, String addressId) async {
    try {
      await firestore.collection('addresses').doc(addressId).update({
        'name': addressModel.name,
        'phone': addressModel.phone,
        'address': addressModel.address,
        'province': addressModel.selectedProvinceName,
        'district': addressModel.selectedDistrictName,
        'ward': addressModel.selectedWardName,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address updated successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update address'),
        ),
      );
    }
  }

  String _autoID() {
    var now = DateTime.now();
    return now.millisecondsSinceEpoch.toString();
  }
}
