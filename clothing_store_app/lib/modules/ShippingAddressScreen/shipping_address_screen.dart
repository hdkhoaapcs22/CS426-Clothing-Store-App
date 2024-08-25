import 'package:flutter/material.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:iconsax/iconsax.dart';
import 'package:clothing_store_app/utils/localfiles.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("shipping_address"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Expanded(
              child: StreamBuilder(
                stream: UserInformationService().getUserInfomationStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Lottie.asset(
                          Localfiles.loading,
                          width: MediaQuery.of(context).size.width * 0.2,
                        ));
                  } else if (!snapshot.hasData ||
                      snapshot.data?.data() == null) {
                    return const Center(child: Text('User data not found'));
                  }

                  var userData = snapshot.data!.data()!;
                  List<dynamic>? shippingInfoList =
                      userData['shippingInfoList'];

                  if (shippingInfoList == null) {
                    print('No addresses found.');
                    return Center(child: Text('No addresses found.'));
                  }

                  String? _defaultShippingInfo =
                      userData['defaultShippingInfo'];

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    itemCount: shippingInfoList.length,
                    itemBuilder: (context, index) {
                      String shippingInfoString = shippingInfoList[index];
                      List<String> shippingInfoParts =
                          shippingInfoString.split(',');

                      String name = shippingInfoParts[0].trim();
                      String phone = shippingInfoParts[1].trim();
                      String address = shippingInfoParts[2].trim();

                      return Column(
                        children: [
                          Slidable(
                            key: ValueKey(shippingInfoString),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      shippingInfoList.removeAt(index);
                                      UserInformationService()
                                          .deleteShippingInfo(
                                              shippingInfoString);

                                      _actionAfterDeleteShippingInfo(
                                        shippingInfoString,
                                        shippingInfoList,
                                        _defaultShippingInfo,
                                      );
                                    });
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.005),
                              leading:
                                  Icon(Icons.location_pin, color: Colors.brown),
                              title: Text(
                                '$name - $phone',
                                style: TextStyles(context).getRegularStyle(),
                              ),
                              subtitle: Text(address),
                              trailing: Transform.scale(
                                scale: 1.5,
                                child: Radio<String>(
                                  value: shippingInfoString,
                                  groupValue: _defaultShippingInfo,
                                  onChanged: (value) {
                                    setState(() {
                                      _defaultShippingInfo = value;
                                      UserInformationService()
                                          .setDefaultShippingInfo(value!);
                                    });
                                  },
                                  activeColor: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                          _buildDivider(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CommonButton(
              onTap: () {
                NavigationServices(context).pushAddNewShippingAddressScreen();
              },
              radius: 30.0,
              backgroundColor: AppTheme.brownButtonColor,
              buttonTextWidget: Text(
                AppLocalizations(context).of("add_new_shipping_address"),
                style: TextStyles(context).getButtonTextStyle(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.02,
        ),
        child: CommonButton(
          onTap: () {
            Navigator.pop(context);
          },
          radius: 30.0,
          backgroundColor: AppTheme.brownButtonColor,
          buttonTextWidget: Text(
            AppLocalizations(context).of("apply"),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }

  void _actionAfterDeleteShippingInfo(
    String shippingInfoString,
    List<dynamic> shippingInfoList,
    String? defaultShippingInfo,
  ) {
    if (shippingInfoString == defaultShippingInfo) {
      if (shippingInfoList.isNotEmpty) {
        defaultShippingInfo = shippingInfoList[0];
        UserInformationService().setDefaultShippingInfo(shippingInfoList[0]);
      } else {
        defaultShippingInfo = null;
        UserInformationService().setDefaultShippingInfo(null);
      }
    }
  }

  Widget _buildDivider({
    double height = 16.0,
    double indent = 16.0,
    double endIndent = 16.0,
    double thickness = 0.2,
  }) {
    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      thickness: thickness,
      color: Colors.grey[400],
    );
  }
}
