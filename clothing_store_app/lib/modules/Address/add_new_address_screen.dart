import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;

  List<String> provinces = ["Province 1", "Province 2", "Province 3"];
  List<String> districts = ["District 1", "District 2", "District 3"];
  List<String> wards = ["Ward 1", "Ward 2", "Ward 3"];

  Future<void> _useCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert coordinates to address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      setState(() {
        selectedProvince = placemark.administrativeArea;
        selectedDistrict = placemark.subAdministrativeArea;
        selectedWard = placemark.locality;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Detail Address',
              ),
            ),
            SizedBox(height: 16),
            DropdownSearch<String>(
              items: provinces,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                containerBuilder: (ctx, popupWidget) {
                  return Flexible(
                    child: Container(
                      child: popupWidget,
                      color: Color(0xFF2F772A),
                    ),
                  );
                },
              ),
              dropdownBuilder: (context, String? item) {
                return Text(item ?? "Select Province");
              },
              onChanged: (value) {
                setState(() {
                  selectedProvince = value;
                  // Load districts based on selected province
                });
              },
            ),
            SizedBox(height: 16),
            DropdownSearch<String>(
              items: districts,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                containerBuilder: (ctx, popupWidget) {
                  return Flexible(
                    child: Container(
                      child: popupWidget,
                      color: Color(0xFF2F772A),
                    ),
                  );
                },
              ),
              dropdownBuilder: (context, String? item) {
                return Text(item ?? "Select District");
              },
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  // Load wards based on selected district
                });
              },
            ),
            SizedBox(height: 16),
            DropdownSearch<String>(
              items: wards,
              popupProps: PopupProps.bottomSheet(
                fit: FlexFit.loose,
                bottomSheetProps: BottomSheetProps(
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
                containerBuilder: (ctx, popupWidget) {
                  return Flexible(
                    child: Container(
                      child: popupWidget,
                      color: Color(0xFF2F772A),
                    ),
                  );
                },
              ),
              dropdownBuilder: (context, String? item) {
                return Text(item ?? "Select Ward");
              },
              onChanged: (value) {
                setState(() {
                  selectedWard = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Save address logic
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Use your location'),
              onPressed: () {
                _useCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }
}
