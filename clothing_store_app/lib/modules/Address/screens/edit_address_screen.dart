import 'package:clothing_store_app/models/address.dart';
import 'package:clothing_store_app/modules/Address/widgets/address_form.dart';
import 'package:clothing_store_app/modules/Address/widgets/delete_button.dart';
import 'package:clothing_store_app/modules/Address/widgets/save_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/provincedata_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/address_model.dart';
import '../../../utils/enum.dart';
import '../../../widgets/custom_app_bar.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;
  final int index;

  EditAddressScreen({super.key, required this.address, required this.index});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
          appBar: CustomAppBar(
            addressModel: addressModel,
            title: "edit_address",
            onPressed: () {
              NavigationServices(context).pop();
              addressModel.clear();
            },
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                AddressForm(
                    addressModel: addressModel,
                    provinceList: ProvincedataUtils.provinceList,
                    districtMap: ProvincedataUtils.districtMap,
                    wardMap: ProvincedataUtils.wardMap),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                DeleteButton(addressModel: addressModel, index: widget.index),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SaveButton(
                    addressModel: addressModel,
                    actionType: ActionType.update,
                    index: widget.index),
              ],
            ),
          ),
        );
      },
    );
  }
}
