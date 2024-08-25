class OrderInfo {
  String subTotalPrice;
  String totalPrice;
  String deliveryFee;
  List<Map<String, dynamic>> clothesSold;
  List<String>? couponID;
  String? discount;
  String? shippingAddress;
  String? shippingType;
  String beginShippingDate;
  String endShippingDate;
  String? paymentMethod;
  int totalItems;

  OrderInfo({
    required this.subTotalPrice,
    required this.totalPrice,
    required this.deliveryFee,
    required this.clothesSold,
    required this.totalItems,
    this.couponID,
    this.discount,
    this.shippingAddress,
    this.shippingType,
    this.beginShippingDate = "",
    this.endShippingDate = "",
    this.paymentMethod,
  });

  set setShippingAddress(String address) {
    shippingAddress = address;
  }

  set setShippingType(String type) {
    shippingType = type;
  }

  set setBeginShippingDate(String date) {
    beginShippingDate = date;
  }

  set setEndShippingDate(String date) {
    endShippingDate = date;
  }

  set setPaymentMethod(String method) {
    paymentMethod = method;
  }
}
