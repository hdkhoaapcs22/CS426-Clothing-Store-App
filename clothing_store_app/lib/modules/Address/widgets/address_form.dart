import 'package:flutter/material.dart';

import '../../../languages/appLocalizations.dart';
import '../../../providers/address_model.dart';
import '../../../widgets/common_dropdownsearch.dart';
import '../../../widgets/common_textfield.dart';

class AddressForm extends StatelessWidget {
  final AddressModel addressModel;
  final List<String> provinceList;
  final Map<String, List<String>>? districtMap;
  final Map<String, List<String>>? wardMap;

  AddressForm({
    required this.addressModel,
    required this.provinceList,
    required this.districtMap,
    required this.wardMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          hintText: AppLocalizations(context).of("name"),
          textEditingController: addressModel.fullNameController,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("phone_number"),
          textEditingController: addressModel.phoneNumberController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("detail_address"),
          textEditingController: addressModel.addressController,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: provinceList,
          hintText: AppLocalizations(context).of("select_province"),
          selectedItem: addressModel.province,
          isBottomSheet: true,
          onChanged: (item) {
            addressModel.province = item;
            addressModel.district = null;
            addressModel.ward = null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: districtMap![addressModel.province] ?? [],
          hintText: AppLocalizations(context).of("select_district"),
          selectedItem: addressModel.district,
          isBottomSheet: true,
          onChanged: (item) {
            addressModel.district = item;
            addressModel.ward = null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: wardMap![addressModel.province_district] ?? [],
          hintText: AppLocalizations(context).of("select_ward"),
          selectedItem: addressModel.ward,
          isBottomSheet: true,
          onChanged: (item) {
            addressModel.ward = item;
          },
        ),
      ],
    );
  }
}
