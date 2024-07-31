import 'package:clothing_store_app/modules/Address/widgets/address_list.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/address_utils.dart';
import 'package:flutter/material.dart';
import '../../../languages/appLocalizations.dart';
import 'add_new_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen>
    with AddressUtils {
  Future<List<String>>? _addressFuture;
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
          return AddressList(
              addressList: addressList,
              onAddressTap: _onAddressTap,
              selectedIndex: _selectedIndex);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddNewAddress();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
