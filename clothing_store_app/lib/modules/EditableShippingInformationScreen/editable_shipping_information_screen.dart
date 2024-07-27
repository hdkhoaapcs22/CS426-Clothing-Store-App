import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../models/shipping_information.dart';
import '../../utils/address_utils.dart';
import 'address_list_view.dart';

class EditableShippingInformationScreen extends StatefulWidget {
  @override
  _EditableShippingInformationScreenState createState() =>
      _EditableShippingInformationScreenState();
}

class _EditableShippingInformationScreenState
    extends State<EditableShippingInformationScreen> {
  late Future<List<String>> _addressFuture;
  late int _selectedIndex;
  int i = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
    _addressFuture = AddressUtils.loadAddresses(context);
  }

  void _onAddressTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _loadAddresses() {
    setState(() {
      _addressFuture = AddressUtils.loadAddresses(context);
    });
  }

  void _onEditAddress(ShippingInformation address, int index) {
    NavigationServices(context).pushEditAddressScreen(
        address, index, (result) async => _loadAddresses());
  }

  void _onAddNewAddress() {
    NavigationServices(context).pushAddNewAddressScreen((result) async {
      _loadAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build EditableShippingInformationScreen" + i.toString());
    i++;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of("shipping_information")),
      ),
      body: FutureBuilder<List<String>>(
        future: _addressFuture,
        builder: (context, snapshot) {
          print("build FutureBuilder");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final addressList = snapshot.data ?? [];

          return AddressListView(
              addressList: addressList,
              selectedIndex: _selectedIndex,
              onAddressTap: _onAddressTap,
              onEditAddress: _onEditAddress);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddNewAddress,
        backgroundColor: Color.fromRGBO(88, 57, 39, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
