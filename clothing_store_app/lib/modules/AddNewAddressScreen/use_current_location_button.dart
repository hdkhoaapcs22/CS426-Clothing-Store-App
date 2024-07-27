import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../providers/shipping_information_model.dart';
import '../../widgets/common_button.dart';

class UseCurrentLocationButton extends StatelessWidget {
  final ShippingInformationModel shippingInformationModel;

  const UseCurrentLocationButton({
    Key? key,
    required this.shippingInformationModel,
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
          shippingInformationModel.addressController!.text =
              placemark.street ?? '';
          shippingInformationModel.province =
              placemark.administrativeArea ?? '';
          shippingInformationModel.district =
              placemark.subAdministrativeArea ?? '';
          shippingInformationModel.ward = placemark.locality ?? '';
        }
      },
    );
  }
}
