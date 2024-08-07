import 'package:clothing_store_app/modules/ShippingInformation/widgets/address_form.dart';
import 'package:clothing_store_app/widgets/custom_app_bar.dart';
import 'package:clothing_store_app/modules/ShippingInformation/widgets/save_button.dart';
import 'package:clothing_store_app/modules/ShippingInformation/widgets/use_current_location_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/shipping_information_model.dart';
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
    return Consumer<ShippingInformationModel>(
      builder: (context, shippingInformationModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            shippingInformationModel: shippingInformationModel,
            title: "add_new_address",
            onPressed: () {
              NavigationServices(context).pop();
              shippingInformationModel.clear();
            },
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                AddressForm(
                    shippingInformationModel: shippingInformationModel,
                    provinceList: ProvincedataUtils.provinceList,
                    districtMap: ProvincedataUtils.districtMap,
                    wardMap: ProvincedataUtils.wardMap),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                UseCurrentLocationButton(
                    shippingInformationModel: shippingInformationModel),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SaveButton(
                  shippingInformationModel: shippingInformationModel,
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
