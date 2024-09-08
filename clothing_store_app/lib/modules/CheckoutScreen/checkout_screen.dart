import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import '../../class/order_info.dart';
import 'package:clothing_store_app/services/database/user_information.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:lottie/lottie.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:intl/intl.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';

class CheckoutScreen extends StatefulWidget {
  OrderInfo order;

  CheckoutScreen({required this.order});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _shippingType;
  late String _beginShippingDate;
  late String _endShippingDate;

  @override
  void initState() {
    super.initState();
    _shippingType = 'economy';
    _calculateEstimatedArrival(_shippingType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonDetailedAppBarView(
              title: AppLocalizations(context).of("checkout"),
              prefixIconData: Iconsax.arrow_left,
              onPrefixIconClick: () {
                Navigator.pop(context);
              },
              iconColor: AppTheme.primaryTextColor,
              backgroundColor: AppTheme.backgroundColor,
            ),
            Text(
              AppLocalizations(context).of('shipping_address'),
              style: TextStyles(context)
                  .getLabelLargeStyle(false)
                  .copyWith(fontSize: 18, color: AppTheme.brownButtonColor),
            ),
            _buildShippingAddressTile(context),
            _buildDivider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              AppLocalizations(context).of('choose_shipping_type'),
              style: TextStyles(context)
                  .getLabelLargeStyle(false)
                  .copyWith(fontSize: 18, color: AppTheme.brownButtonColor),
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping, color: Colors.brown),
              title: Text(AppLocalizations(context).of(_shippingType)),
              subtitle: Text('$_beginShippingDate - $_endShippingDate'),
              trailing: _buildChangeButton(context, () {
                NavigationServices(context)
                    .pushChooseShippingScreen(_shippingType)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _shippingType = value;
                    });
                  }
                });
              }),
            ),
            _buildDivider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              AppLocalizations(context).of('order_list'),
              style: TextStyles(context)
                  .getLabelLargeStyle(false)
                  .copyWith(fontSize: 18, color: AppTheme.brownButtonColor),
            ),
            _buildOrderItemList(context),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: CommonButton(
          onTap: () {
            NavigationServices(context).pushPaymentMethodsScreen(widget.order);
          },
          radius: 30.0,
          backgroundColor: Colors.brown,
          buttonTextWidget: Text(
            AppLocalizations(context).of('continue_to_payment'),
            style: TextStyles(context).getButtonTextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _buildShippingAddressTile(BuildContext context) {
    return StreamBuilder(
      stream: UserInformationService().getUserInfomationStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ));
        } else if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(child: Text('User data not found'));
        }

        dynamic defaultAddress = snapshot.data?.data()?['defaultShippingInfo'];

        if (defaultAddress == null || defaultAddress.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showAddAddressDialog();
          });

          return ListTile(
            leading: Icon(Icons.home, color: Colors.brown),
            title: Text(AppLocalizations(context).of('home')),
            subtitle:
                Text(AppLocalizations(context).of('no_address_available')),
            trailing: _buildChangeButton(
              context,
              () {
                NavigationServices(context).pushShippingAddressScreen();
              },
            ),
          );
        }

        List<String> addressParts = defaultAddress.split(', ');

        if (addressParts.length < 3) {
          return const SizedBox.shrink();
        }

        String name = addressParts[0].trim();
        String phone = addressParts[1].trim();
        String address = addressParts[2].trim();

        return ListTile(
          leading: const Icon(Icons.home, color: Colors.brown),
          title: Text(
            '$name - $phone',
            style: TextStyles(context).getRegularStyle(),
          ),
          subtitle: Text(address),
          trailing: _buildChangeButton(context, () {
            NavigationServices(context).pushShippingAddressScreen();
          }),
        );
      },
    );
  }

  Widget _buildChangeButton(BuildContext context, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.brown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      ),
      child: Text(
        AppLocalizations(context).of('change'),
        style: TextStyles(context).getButtonTextStyle2(),
      ),
    );
  }

  Widget _buildOrderItemList(
    BuildContext context,
  ) {
    return Expanded(
      child: ListView(
        children: widget.order.clothesSold.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(item['imageURL']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item['name'],
                        style: TextStyles(context).getBoldStyle().copyWith(
                              fontSize: 16,
                            ),
                      ),
                      Text(
                        '${AppLocalizations(context).of("size")}: ${item['size']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '\$${item['price']}',
                        style: TextStyles(context).getBoldStyle().copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
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

  Future<void> _showAddAddressDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      NavigationServices(context).popToMyCart();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brownButtonColor,
                    ),
                    child: Text(
                      AppLocalizations(context).of("no"),
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backgroundColor),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      NavigationServices(context)
                          .pushAddNewShippingAddressScreen()
                          .then((value) {
                        if (value == null) {
                          _showAddAddressDialog();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.brownButtonColor,
                    ),
                    child: Text(
                      AppLocalizations(context).of("yes"),
                      style: TextStyles(context)
                          .getRegularStyle()
                          .copyWith(color: AppTheme.backgroundColor),
                    ))
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: Text(
                AppLocalizations(context).of("no_address_found"),
                style: TextStyles(context)
                    .getLabelLargeStyle(false)
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ));
  }

  void _calculateEstimatedArrival(String shippingType) {
    Map<String, String> shippingOptions = {
      'economy': '5-7',
      'regular': '3-5',
      'cargo': '2-3',
    };

    List<String> days = shippingOptions[shippingType]!.split('-');

    int minDays = int.parse(days[0]);
    int maxDays = int.parse(days[1]);

    DateTime minEstimatedArrivalDate =
        DateTime.now().add(Duration(days: minDays));
    DateTime maxEstimatedArrivalDate =
        DateTime.now().add(Duration(days: maxDays));
    _beginShippingDate =
        DateFormat('dd MMMM yyyy').format(minEstimatedArrivalDate);
    _endShippingDate =
        DateFormat('dd MMMM yyyy').format(maxEstimatedArrivalDate);
  }
}
