class ClothItem {
  String name;
  String description;
  String type;
  Map<String,int> sizeWithQuantity;
  String gender;
  String brand;
  String clothImageURL;
  double price;
  double review;

  ClothItem({
    required this.name,
    required this.description,
    required this.type,
    required this.sizeWithQuantity,
    required this.gender,
    required this.brand,
    required this.clothImageURL,
    required this.price,
    required this.review,
  });
}
