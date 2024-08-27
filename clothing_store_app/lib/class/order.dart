class Order {
  final double subTotalPrice;
  final double totalPrice;
  final double deliveryFee;
  final List<Map<String, dynamic>> clothesSold;
  final String? couponID;
  final double? discount;

  Order({
    required this.subTotalPrice,
    required this.totalPrice,
    required this.deliveryFee,
    required this.clothesSold,
    this.couponID,
    this.discount,
  });
}
