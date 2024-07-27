import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';
import '../../providers/shipping_information_model.dart';
import '../../widgets/common_dropdownsearch.dart';
import '../../widgets/common_textfield.dart';

class AddressForm extends StatelessWidget {
  final ShippingInformationModel shippingInformationModel;
  final List<String> provinceList;
  final Map<String, List<String>>? districtMap;
  final Map<String, List<String>>? wardMap;

  AddressForm({
    required this.shippingInformationModel,
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
          textEditingController: shippingInformationModel.fullNameController,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("phone_number"),
          textEditingController: shippingInformationModel.phoneNumberController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("detail_address"),
          textEditingController: shippingInformationModel.addressController,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: provinceList,
          hintText: AppLocalizations(context).of("select_province"),
          selectedItem: shippingInformationModel.province,
          onChanged: (item) {
            shippingInformationModel.province = item;
            shippingInformationModel.district = null;
            shippingInformationModel.ward = null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: districtMap![shippingInformationModel.province] ?? [],
          hintText: AppLocalizations(context).of("select_district"),
          selectedItem: shippingInformationModel.district,
          onChanged: (item) {
            shippingInformationModel.district = item;
            shippingInformationModel.ward = null;
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonDropdownSearch<String>(
          items: wardMap![shippingInformationModel.province_district] ?? [],
          hintText: AppLocalizations(context).of("select_ward"),
          selectedItem: shippingInformationModel.ward,
          onChanged: (item) {
            shippingInformationModel.ward = item;
          },
        ),
      ],
    );
  }
}
