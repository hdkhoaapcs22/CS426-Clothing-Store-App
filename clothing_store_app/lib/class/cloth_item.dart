class ClothItem {
  String type;
  String size;
  String gender;
  String brand;
  String clothImageURL;
  double price;
  double review;
  int quantity;
  bool isAvailable;

  ClothItem({
    required this.type,
    required this.size,
    required this.gender,
    required this.brand,
    required this.clothImageURL,
    required this.price,
    required this.review,
    required this.quantity,
    this.isAvailable = true,
  });
}
