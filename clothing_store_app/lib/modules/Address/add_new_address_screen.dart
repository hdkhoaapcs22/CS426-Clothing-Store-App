import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../languages/appLocalizations.dart';
import '../../providers/address_model.dart';
import '../../utils/address_utils.dart';
import '../../utils/enum.dart';

class AddNewAddressScreen extends StatefulWidget {
  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen>
    with AddressUtils {
      
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressModel>(
      builder: (context, addressModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations(context).of("add_new_address")),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                NavigationServices(context).pop();
                addressModel.clear();
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildAddressFields(context, addressModel),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildUseCurrentLocationButton(addressModel),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildSaveButton(context, addressModel, ActionType.add, null),
              ],
            ),
          ),
        );
      },
    );
  }
}
