import 'package:clothing_store_app/modules/ShippingInformationScreen/address_list.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/address_utils.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';

class ShippingInformationScreen extends StatefulWidget {
  @override
  State<ShippingInformationScreen> createState() =>
      _ShippingInformationScreenState();
}

class _ShippingInformationScreenState extends State<ShippingInformationScreen> {
  Future<List<String>>? _addressFuture;
  late int _selectedIndex;

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

  void _onAddNewAddress() {
    NavigationServices(context).pushAddNewAddressScreen((result) async {
      _loadAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of("shipping_information")),
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
        onPressed: _onAddNewAddress,
        backgroundColor: const Color.fromRGBO(88, 57, 39, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
