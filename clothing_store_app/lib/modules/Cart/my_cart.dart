import 'package:clothing_store_app/services/database/user.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../../class/ordered_item.dart';
import '../../services/database/cart.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with TickerProviderStateMixin {
  late SlidableController controller;
  late TextEditingController promoCodeController;
  late double subTotalPrice, discount, deliveryFee, totalPrice;
  late List<dynamic> orderedItems;

  @override
  void initState() {
    super.initState();
    controller = SlidableController(this);
    promoCodeController = TextEditingController();
    discount = 0.0;
    deliveryFee = 0.0;
    totalPrice = 0.0;
    orderedItems = [];
    // calculateSubtotalPrice();
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
                      // quantity: doc['quantity'],
                    ))
                .toList();
            return Scaffold(
              bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.34,
                child: getBottomBarUI(),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height, left: 5, right: 5),
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    CommonAppBarView(
                      topPadding: 0,
                      iconData: Icons.arrow_back,
                      onBackClick: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text(
                        'My Cart',
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
                    // Remove item from cart
                    CartService().removeItemFromCart(
                        clothItemID: orderedItems[index].clothBaseID);
                    // Update total price
                    calculateTotalPrice();
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
                    'Size: ${orderedItems[index].size}',
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
                        setState(() {
                          orderedItems[index].orderQuantity += 1;
                          // calculateSubtotalPrice(),
                          // calculateTotalPrice(),
                        });
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
            'Remove from Cart?',
            style: TextStyles(context).getBoldStyle().copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 16),
          detailActiveOrder(index, false),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Cancel deletion
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.brown,
                    backgroundColor: Colors.grey[300],
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // Confirm deletion
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                  ),
                  child:
                      const Text('Yes, Remove', style: TextStyle(fontSize: 16)),
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
                    onTap: () {
                      // Apply promo code
                    },
                    radius: 30.0,
                    backgroundColor: AppTheme.brownButtonColor,
                    buttonTextWidget: Text(
                      'Promo Code',
                      style: TextStyles(context).getButtonTextStyle(),
                    ),
                  )),

              const SizedBox(height: 13),

              titlePrice(title: "Sub-Total", price: totalPrice),
              const SizedBox(height: 8),

              titlePrice(title: "Delivery Fee", price: 0.0),
              const SizedBox(height: 8),

              titlePrice(title: "Discount", price: 0.0),
              const SizedBox(height: 8),

              titlePrice(title: "Total", price: totalPrice),
              const SizedBox(height: 12),

              // commonButton
              CommonButton(
                onTap: () {
                  // Proceed to checkout
                },
                radius: 30.0,
                backgroundColor: AppTheme.brownButtonColor,
                buttonTextWidget: Text(
                  'Proceed to Checkout',
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
              child: Text(title,
                  style: TextStyles(context)
                      .getDescriptionStyle()
                      .copyWith(fontSize: 18))),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$$price',
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void calculateSubtotalPrice() {
    setState(() {
      subTotalPrice = 0.0;
      for (var item in orderedItems) {
        subTotalPrice += item.price * item.orderQuantity;
      }
    });
  }

  void calculateTotalPrice() {
    setState(() {});
  }
}
