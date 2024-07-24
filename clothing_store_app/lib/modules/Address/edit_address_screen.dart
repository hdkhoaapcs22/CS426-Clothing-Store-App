import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;

  List<String> provinces = List.generate(100, (index) => "Province $index");
  List<String> districts = ["District 1", "District 2", "District 3"];
  List<String> wards = ["Ward 1", "Ward 2", "Ward 3"];

  void _useCurrentLocation() {
    // Add your location fetching logic here
    print('Fetching current location...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
      ),
      body: SingleChildScrollView(
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
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
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
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
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
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
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
              onPressed: _useCurrentLocation,
            ),
          ],
        ),
      ),
    );
  }
}
