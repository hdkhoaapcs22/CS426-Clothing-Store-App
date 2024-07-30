import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../languages/appLocalizations.dart';
import '../models/address.dart';
import '../modules/Address/use_current_location.dart';
import '../providers/address_model.dart';
import '../repositories/address_repository.dart';
import '../routes/navigation_services.dart';
import '../widgets/common_OK_dialog.dart';
import '../widgets/common_button.dart';
import '../widgets/common_dropdownsearch.dart';
import '../widgets/common_textfield.dart';
import '../widgets/common_two_options_dialog.dart';
import 'enum.dart';

mixin AddressUtils {
  Future<List<String>> loadAddresses(BuildContext context) {
    final addressRepository =
        Provider.of<AddressRepository>(context, listen: false);
    return addressRepository.getAllStrings();
  }

  void onChanged(BuildContext context, AddressModel addressModel,
      ActionType actionType, int? index) {
    final addressRepository =
        Provider.of<AddressRepository>(context, listen: false);

    switch (actionType) {
      case ActionType.add:
        addressRepository
            .add(Address.fromAddressString(addressModel.toString()));
        break;
      case ActionType.update:
        addressRepository.update(
            Address.fromAddressString(addressModel.toString()), index!);
        break;
      case ActionType.delete:
        addressRepository.delete(index!);
        break;
    }

    addressModel.clear();
  }

  bool isFormValid(AddressModel addressModel) {
    return addressModel.fullNameController!.text.isNotEmpty &&
        addressModel.phoneNumberController!.text.isNotEmpty &&
        addressModel.addressController!.text.isNotEmpty &&
        addressModel.province != null &&
        addressModel.district != null &&
        addressModel.ward != null;
  }

  Widget buildAddressFields(BuildContext context, AddressModel addressModel) {
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
          items: districtMap?[addressModel.province] ?? [],
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
          items: wardMap?[addressModel.province_district] ?? [],
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

  Widget buildUseCurrentLocationButton(AddressModel addressModel) {
    return CommonButton(
      buttonText: "use_current_location",
      onTap: () async {
        Placemark? placemark = await useCurrentLocation();
        if (placemark != null) {
          addressModel.addressController!.text = placemark.street ?? '';
          addressModel.province = placemark.administrativeArea ?? '';
          addressModel.district = placemark.subAdministrativeArea ?? '';
          addressModel.ward = placemark.locality ?? '';
        }
      },
    );
  }

  Widget buildSaveButton(BuildContext context, AddressModel addressModel,
      ActionType actionType, int? index) {
    return CommonButton(
      buttonText: "save",
      onTap: () {
        if (isFormValid(addressModel)) {
          if (actionType == ActionType.add) {
            onChanged(context, addressModel, actionType, index);
            showOKDialog(context, "address_added_successfully");
          } else {
            onChanged(context, addressModel, actionType, index);
            showOKDialog(context, "address_updated_successfully");
          }
        } else {
          showSnackBar(context, "please_fill_in_all_fields");
        }
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations(context).of(message)),
    ));
  }

  void showOKDialog(BuildContext context, String message) {
    CommonOKDialog(
      title: AppLocalizations(context).of("notification"),
      message: AppLocalizations(context).of(message),
      onOKPressed: () {
        Navigator.of(context).pop();
        NavigationServices(context).pop();
      },
    ).show(context);
  }

  void showTwoOptionsDialog(BuildContext context, String message,
      String option1Text, String option2Text, Function onOption2Pressed) {
    CommonTwoOptionsDialog(
      title: AppLocalizations(context).of("notification"),
      message: AppLocalizations(context).of(message),
      option1Text: AppLocalizations(context).of(option1Text),
      option2Text: AppLocalizations(context).of(option2Text),
      onOption1Pressed: () {
        Navigator.of(context).pop();
      },
      onOption2Pressed: () {
        Navigator.of(context).pop();
        onOption2Pressed();
      },
    ).show(context);
  }
}
