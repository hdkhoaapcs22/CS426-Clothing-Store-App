import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../providers/address_model.dart';
import '../../../widgets/common_button.dart';

class UseCurrentLocationButton extends StatelessWidget {
  final AddressModel addressModel;

  const UseCurrentLocationButton({
    Key? key,
    required this.addressModel,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      buttonText: "use_current_location",
      onTap: () async {
        Placemark? placemark = await _useCurrentLocation();

        if (placemark != null) {
          addressModel.addressController!.text = placemark.street ?? '';
          addressModel.province = placemark.administrativeArea ?? '';
          addressModel.district = placemark.subAdministrativeArea ?? '';
          addressModel.ward = placemark.locality ?? '';
        }
      },
    );
  }
}
