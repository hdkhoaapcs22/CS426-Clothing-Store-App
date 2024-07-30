import 'package:clothing_store_app/models/address.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../languages/appLocalizations.dart';
import '../../providers/address_model.dart';
import '../../utils/address_utils.dart';
import '../../utils/enum.dart';
import '../../widgets/common_button.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;
  final int index;

  EditAddressScreen({required this.address, required this.index});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen>
    with AddressUtils {
  @override
  void initState() {
    super.initState();
    _initializeAddressModel();
  }

  void _initializeAddressModel() {
    final addressModel = Provider.of<AddressModel>(context, listen: false);
    addressModel.setAddress(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressModel>(
      builder: (context, addressModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations(context).of("edit_address")),
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
                _buildDeleteButton(addressModel, widget.index),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                buildSaveButton(
                    context, addressModel, ActionType.update, widget.index),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDeleteButton(AddressModel addressModel, int index) {
    return CommonButton(
        buttonText: "delete",
        onTap: () {
          showTwoOptionsDialog(
              context,
              "are_you_sure_you_want_to_delete_this_address",
              "cancel",
              "delete", () {
            onChanged(context, addressModel, ActionType.delete, index);
            showOKDialog(context, "address_deleted_successfully");
          });
        });
  }
}
