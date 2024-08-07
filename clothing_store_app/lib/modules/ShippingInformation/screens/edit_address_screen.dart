import 'package:clothing_store_app/models/shipping_information.dart';
import 'package:clothing_store_app/modules/ShippingInformation/widgets/address_form.dart';
import 'package:clothing_store_app/modules/ShippingInformation/widgets/delete_button.dart';
import 'package:clothing_store_app/modules/ShippingInformation/widgets/save_button.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/utils/provincedata_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/shipping_information_model.dart';
import '../../../utils/enum.dart';
import '../../../widgets/custom_app_bar.dart';

class EditAddressScreen extends StatefulWidget {
  final ShippingInformation address;
  final int index;

  EditAddressScreen({super.key, required this.address, required this.index});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  void initState() {
    super.initState();
    _initializeShippingInformationModel();
  }

  void _initializeShippingInformationModel() {
    final shippingInformationModel =
        Provider.of<ShippingInformationModel>(context, listen: false);
    shippingInformationModel.setAddress(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingInformationModel>(
      builder: (context, ShippingInformationModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            shippingInformationModel: ShippingInformationModel,
            title: "edit_address",
            onPressed: () {
              NavigationServices(context).pop();
              ShippingInformationModel.clear();
            },
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                AddressForm(
                    shippingInformationModel: ShippingInformationModel,
                    provinceList: ProvincedataUtils.provinceList,
                    districtMap: ProvincedataUtils.districtMap,
                    wardMap: ProvincedataUtils.wardMap),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                DeleteButton(
                    shippingInformationModel: ShippingInformationModel,
                    index: widget.index),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SaveButton(
                    shippingInformationModel: ShippingInformationModel,
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
