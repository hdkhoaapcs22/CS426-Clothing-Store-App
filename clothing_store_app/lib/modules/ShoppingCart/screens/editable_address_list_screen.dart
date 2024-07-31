import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import '../../../languages/appLocalizations.dart';
import '../../../models/address.dart';
import '../../../utils/address_utils.dart';
import '../../Address/screens/add_new_address_screen.dart';
import '../../Address/screens/edit_address_screen.dart';
import '../address_list_view.dart';

class EditableAddressListScreen extends StatefulWidget {
  @override
  _EditableAddressListScreenState createState() =>
      _EditableAddressListScreenState();
}

class _EditableAddressListScreenState extends State<EditableAddressListScreen>
    with AddressUtils {
  late Future<List<String>> _addressFuture;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
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

  void _onEditAddress(Address address, int index) {
    NavigationServices(context).pushMaterialPageRoute(
      EditAddressScreen(address: address, index: index),
      onResult: (result) async => _loadAddresses(),
    );
  }

  void _onAddNewAddress() {
    NavigationServices(context).pushMaterialPageRoute(
      AddNewAddressScreen(),
      onResult: (result) async => _loadAddresses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of("address_list")),
      ),
      body: FutureBuilder<List<String>>(
        future: _addressFuture,
        builder: (context, snapshot) {
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
