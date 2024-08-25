import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../languages/appLocalizations.dart';
import '../../widgets/common_textfield.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import '../../widgets/common_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_detailed_app_bar.dart';

class AddNewShippingAddressScreen extends StatefulWidget {
  const AddNewShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _AddNewShippingAddressScreenState createState() =>
      _AddNewShippingAddressScreenState();
}

class _AddNewShippingAddressScreenState
    extends State<AddNewShippingAddressScreen> {
  TextEditingController? _fullNameController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("add_new_address"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            _buildAddressForm(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildUseCurrentLocationButton(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCurrentLocationButton(BuildContext context) {
    return CommonButton(
      buttonText: "use_current_location",
      onTap: () async {
        Placemark? placemark = await _useCurrentLocation();

        if (placemark != null) {
          if (placemark.street != null) {
            _addressController!.text += placemark.street!;
          }
          if (placemark.subLocality != null) {
            _addressController!.text += ", " + placemark.subLocality!;
          }
          if (placemark.locality != null) {
            _addressController!.text += ", " + placemark.locality!;
          }
          if (placemark.subAdministrativeArea != null) {
            _addressController!.text += ", " + placemark.administrativeArea!;
          }
          if (placemark.administrativeArea != null) {
            _addressController!.text += ", " + placemark.administrativeArea!;
          }
        }
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CommonButton(
      buttonText: "save",
      onTap: () async {
        if (isFormValid()) {
          try {
            String shippingInfo = _fullNameController!.text +
                ", " +
                _phoneNumberController!.text +
                ", " +
                _addressController!.text;

            await UserInformationService().setDefaultShippingInfo(shippingInfo);
            await UserInformationService().addShippingInfo(shippingInfo);

            _showOKDialog(context);
          } catch (e) {
            _showSnackBar(context, "error_saving_address");
          }
        } else {
          _showSnackBar(context, "please_fill_in_all_fields");
        }
      },
    );
  }

  Widget _buildAddressForm(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          hintText: AppLocalizations(context).of("name"),
          textEditingController: _fullNameController,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("phone_number"),
          textEditingController: _phoneNumberController,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CommonTextField(
          hintText: AppLocalizations(context).of("detail_address"),
          textEditingController: _addressController,
        ),
      ],
    );
  }

  bool isFormValid() {
    return _fullNameController!.text.isNotEmpty &&
        _phoneNumberController!.text.isNotEmpty &&
        _addressController!.text.isNotEmpty;
  }

  void _phoneValidator() {
    if (_phoneNumberController!.text.length > 10) {
      _phoneNumberController!.text =
          _phoneNumberController!.text.substring(0, 10);
    }
  }

  Future<void> _showOKDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brownButtonColor,
                    ),
                    child: Text(
                      AppLocalizations(context).of("ok"),
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backgroundColor),
                    ))
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: Text(
                AppLocalizations(context).of("address_added_successfully"),
                style: TextStyles(context).getLabelLargeStyle(false).copyWith(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations(context).of(message)),
      ),
    );
  }

  Future<Placemark?> _useCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
