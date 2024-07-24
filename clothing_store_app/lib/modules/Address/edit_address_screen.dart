import 'package:clothing_store_app/widgets/common_textfield.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import '../../providers/address_model.dart';

class EditAddressScreen extends StatefulWidget {
  final String addressId;
  final Map<String, dynamic> addressData;

  EditAddressScreen({required this.addressData, required this.addressId});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   final addressModel = Provider.of<AddressModel>(context, listen: false);
  //   addressModel.setName(widget.addressData['name']);
  //   addressModel.setPhone(widget.addressData['phone']);
  //   addressModel.setAddress(widget.addressData['address']);
  //   addressModel.setSelectedProvinceCode(widget.addressData['province']);
  //   addressModel.setSelectedDistrictCode(widget.addressData['district']);
  //   addressModel.setSelectedWardCode(widget.addressData['ward']);

  //   nameController.text = widget.addressData['name'] ?? '';
  //   phoneController.text = widget.addressData['phone'] ?? '';
  //   addressController.text = widget.addressData['address'] ?? '';
  // }

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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
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
              hintText: 'Name',
              textFieldPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                hintText: 'Phone',
              ),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              textEditingController: addressController,
              contentPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              hintTextStyle: const TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              hintText: 'Address',
              textFieldPadding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                addressModel.setSelectedProvinceName(item);
                return Text(item ?? "Select Province");
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getProvinceCode(value);
                  addressModel.setSelectedProvinceCode(code);
                  addressModel.setSelectedDistrictCode(null);
                  addressModel.setSelectedWardCode(null);
                }
              },
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
                if (addressModel.selectedDistrictCode == null) {
                  return const Text("Select District");
                } else {
                  addressModel.setSelectedDistrictName(item);
                  return Text(item ?? "Select District");
                }
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getDistrictCode(value);
                  addressModel.setSelectedDistrictCode(code);
                  addressModel.setSelectedWardCode(null);
                }
              },
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
                if (addressModel.selectedWardCode == null) {
                  return const Text("Select Ward");
                } else {
                  addressModel.setSelectedWardName(item);
                  return Text(item ?? "Select Ward");
                }
              },
              onChanged: (value) async {
                if (value != null) {
                  String? code = await _getWardCode(value);
                  addressModel.setSelectedWardCode(code);
                }
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              buttonText: 'Save',
              onTap: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                }

                if (addressModel.selectedProvinceCode == null ||
                    addressModel.selectedDistrictCode == null ||
                    addressModel.selectedWardCode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please select province, district, and ward'),
                    ),
                  );
                  return;
                }
                addressModel.setName(nameController.text);
                addressModel.setPhone(phoneController.text);
                addressModel.setAddress(addressController.text);
                _updateAddress(addressModel, 'address_id');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateAddress(AddressModel addressModel, String documentId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('addresses').doc(documentId).update({
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
}
