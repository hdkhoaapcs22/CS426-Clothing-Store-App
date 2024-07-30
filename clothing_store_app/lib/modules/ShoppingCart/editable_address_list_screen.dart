import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../models/address.dart';
import '../../utils/address_utils.dart';
import '../../utils/text_styles.dart';
import '../Address/add_new_address_screen.dart';
import '../Address/edit_address_screen.dart';

class EditableAddressListScreen extends StatefulWidget {
  @override
  _EditableAddressListScreenState createState() => _EditableAddressListScreenState();
}

class _EditableAddressListScreenState extends State<EditableAddressListScreen> with AddressUtils {
  late Future<List<String>> _addressFuture;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _addressFuture = loadAddresses(context);
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

          return ListView.builder(
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              final address = Address.fromAddressString(addressList[index]);
              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () => _onAddressTap(index),
                child: _buildAddressCard(address, isSelected, index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddNewAddress,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(Address address, bool isSelected, int index) {
    final edgeInsets = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.symmetric(horizontal: 200.0, vertical: 8.0)
        : const EdgeInsets.all(8.0);

    final padding = MediaQuery.of(context).size.width > 800
        ? const EdgeInsets.all(16.0)
        : const EdgeInsets.all(8.0);

    return Container(
      margin: edgeInsets,
      padding: padding,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.name, style: TextStyles(context).getRegularStyle()),
                const SizedBox(height: 4.0),
                Text(address.phoneNumber, style: TextStyles(context).getSubtitleStyle()),
                const SizedBox(height: 4.0),
                Text(
                  '${address.street}, ${address.ward}, ${address.district}, ${address.city}',
                  style: TextStyles(context).getSubtitleStyle(),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _onEditAddress(address, index),
          ),
        ],
      ),
    );
  }

  void _onAddressTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onEditAddress(Address address, int index) {
    NavigationServices(context).pushMaterialPageRoute(
      EditAddressScreen(address: address, index: index),
      onResult: (result) async => _onLoadAddresses(),
    );
  }

  void _onAddNewAddress() {
    NavigationServices(context).pushMaterialPageRoute(
      AddNewAddressScreen(),
      onResult: (result) async => _onLoadAddresses(),
    );
  }

  void _onLoadAddresses() {
    setState(() {
      _addressFuture = loadAddresses(context);
    });
  }
}
