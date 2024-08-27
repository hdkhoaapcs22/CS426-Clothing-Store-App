import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../../class/ordered_item.dart';
import '../../services/database/cart.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';
import '../CouponScreen/coupon_screen.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with TickerProviderStateMixin {
  late SlidableController controller;
  late TextEditingController promoCodeController;
  late double subTotalPrice, discount, totalPrice;
  final double deliveryFee = 0.8;
  late List<dynamic> orderedItems;

  @override
  void initState() {
    super.initState();
    controller = SlidableController(this);
    promoCodeController = TextEditingController();
    discount = 0.0;
    totalPrice = 0.0;
    orderedItems = [];
  }

  @override
  void dispose() {
    controller.dispose();
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CartService().getItemInCartStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            orderedItems = snapshot.data!.docs
                .map((doc) => OrderedItem(
                      clothBaseID: doc['clothItemID'],
                      name: doc['name'],
                      imageURL: doc['imageURL'],
                      size: doc['size'],
                      price: double.parse(doc['price']),
                      orderQuantity: doc['orderQuantity'],
                      quantity: doc['quantity'],
                    ))
                .toList();
            calculateSubTotalPrice();
            calculateTotalPrice();
            return Scaffold(
              bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.34,
                child: getBottomBarUI(),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height, left: 5, right: 5),
                child: Column(children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: CommonAppBarView(
                        topPadding: 0,
                        iconData: Icons.arrow_back,
                        onBackClick: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Text(
                        AppLocalizations(context).of("my_cart"),
                        style: TextStyles(context).getBoldStyle().copyWith(
                              fontSize: 28,
                            ),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderedItems.length,
                      itemBuilder: (context, index) {
                        return activeOrderWidget(index);
                      },
                    ),
                  ),
                ]),
              ),
            );
          }
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: MediaQuery.of(context).size.width * 0.2,
              ));
        });
  }

  Widget activeOrderWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                autoClose: false,
                onPressed: (_) async {
                  bool tmp = await showModalBottomSheet<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return _buildConfirmationSheet(context, index);
                        },
                      ) ??
                      false;
                  if (!tmp) {
                    controller.openEndActionPane();
                  } else {
                    CartService().removeItemFromCart(
                        clothItemID: orderedItems[index].clothBaseID);
                  }
                },
                backgroundColor: const Color.fromARGB(255, 249, 182, 182),
                foregroundColor: const Color.fromARGB(255, 250, 58, 58),
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          child: Card(child: detailActiveOrder(index))),
    );
  }

  Widget detailActiveOrder(int index, [bool isSlidable = true]) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Product Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(orderedItems[index].imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    orderedItems[index].name,
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '${AppLocalizations(context).of("size")}: ${orderedItems[index].size}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '\$${orderedItems[index].price}',
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          // Quantity Control
          if (isSlidable) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (orderedItems[index].orderQuantity != 1) {
                      CartService().decreaseQuantityOrderItemInCart(
                          clothItemID: orderedItems[index].clothBaseID);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.092,
                    height: MediaQuery.of(context).size.width * 0.092,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  orderedItems[index]
                      .orderQuantity
                      .toString(), // Current quantity
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                    onTap: () {
                      if (orderedItems[index].orderQuantity <
                          orderedItems[index].quantity) {
                        CartService().increaseQuantityOrderItemInCart(
                            clothItemID: orderedItems[index].clothBaseID);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.092,
                      height: MediaQuery.of(context).size.width * 0.092,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    )),
              ],
            ),
          }
        ],
      ),
    );
  }

  Widget _buildConfirmationSheet(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppLocalizations(context).of("remove_from_cart"),
            style: TextStyles(context).getBoldStyle().copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 16),
          detailActiveOrder(index, false),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CommonButton(
                  onTap: () {
                    Navigator.pop(context, false); // Cancel deletion
                  },
                  radius: 30.0,
                  backgroundColor: Colors.grey[300],
                  textColor: const Color.fromRGBO(88, 57, 39, 1),
                  buttonTextWidget: Text(AppLocalizations(context).of("cancel"),
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                child: CommonButton(
                  onTap: () {
                    Navigator.pop(context, true); // Confirm deletion
                  },
                  radius: 30.0,
                  buttonTextWidget: Text(
                      AppLocalizations(context).of("yes_remove"),
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getBottomBarUI() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: CommonButton(
                    padding: const EdgeInsets.only(top: 5, right: 10),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    onTap: () async {
                      // Apply promo code
                      var chosenTicket = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CouponScreen(
                                  totalAmount: subTotalPrice,
                                )),
                      );
                      setState(() {
                        getTotalDiscount(chosenTicket);
                        calculateTotalPrice();
                      });
                    },
                    radius: 30.0,
                    backgroundColor: AppTheme.brownButtonColor,
                    buttonTextWidget: Text(
                      AppLocalizations(context).of("promo_code"),
                      style: TextStyles(context).getButtonTextStyle(),
                    ),
                  )),

              const SizedBox(height: 13),

              titlePrice(title: "sub_total", price: subTotalPrice),
              const SizedBox(height: 8),

              titlePrice(title: "delivery_fee", price: deliveryFee),
              const SizedBox(height: 8),

              titlePrice(title: "discount", price: discount),
              const SizedBox(height: 8),

              titlePrice(title: "total_price", price: totalPrice),
              const SizedBox(height: 12),

              // commonButton
              CommonButton(
                onTap: () {
                  // Proceed to checkout
                },
                radius: 30.0,
                backgroundColor: AppTheme.brownButtonColor,
                buttonTextWidget: Text(
                  AppLocalizations(context).of("proceed_to_checkout"),
                  style: TextStyles(context).getButtonTextStyle(),
                ),
              ),
            ],
          )),
    );
  }

  Widget titlePrice({required String title, required double price}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Text(AppLocalizations(context).of(title),
                  style: TextStyles(context)
                      .getDescriptionStyle()
                      .copyWith(fontSize: 18))),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void getTotalDiscount(chosenTicket) {
    discount = 0.0;
    List<String> promoCodes = [];
    RegExp regExp = RegExp(r'\d+%?');
    for (int i = 0; i < chosenTicket.length; ++i) {
      String? tmpDiscount = regExp.firstMatch(chosenTicket[i])?.group(0);
      promoCodes.add(tmpDiscount!);
    }

    for (int i = 0; i < promoCodes.length; ++i) {
      if (promoCodes[i].contains('%')) {
        discount += subTotalPrice *
            double.parse(promoCodes[i].substring(0, promoCodes[i].length - 1)) /
            100;
      } else {
        discount += double.parse(promoCodes[i]);
      }
    }
  }

  void calculateSubTotalPrice() {
    subTotalPrice = 0.0;
    for (int i = 0; i < orderedItems.length; ++i) {
      subTotalPrice += orderedItems[i].price * orderedItems[i].orderQuantity;
    }
  }

  void calculateTotalPrice() {
    totalPrice = subTotalPrice + deliveryFee - discount;
  }
}
