import 'package:clothing_store_app/modules/Address/widgets/address_form.dart';
import 'package:clothing_store_app/widgets/custom_app_bar.dart';
import 'package:clothing_store_app/modules/Address/widgets/save_button.dart';
import 'package:clothing_store_app/modules/Address/widgets/use_current_location_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/address_model.dart';
import '../../../utils/enum.dart';
import '../../../utils/provincedata_utils.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressModel>(
      builder: (context, addressModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            addressModel: addressModel,
            title: "add_new_address",
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
                UseCurrentLocationButton(addressModel: addressModel),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SaveButton(
                  addressModel: addressModel,
                  actionType: ActionType.add,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
