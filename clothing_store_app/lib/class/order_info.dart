class OrderInfo {
  String totalPrice;
  List<Map<String, dynamic>> clothesSold;
  List<String>? couponID;
  int totalItems;

  OrderInfo({
    required this.totalPrice,
    required this.clothesSold,
    required this.totalItems,
    this.couponID,
  });
}
