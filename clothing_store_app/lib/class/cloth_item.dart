class ClothBase {
  String id;
  String name;
  String description;
  String type;
  String gender;
  String brand;
  double review;
  Future<List<ClothItem>> clothItems;

  ClothBase({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.gender,
    required this.brand,
    required this.review,
    required this.clothItems,
  });
}

class ClothItem {
  String color;
  String clothImageURL;
  Map<String, dynamic> sizeWithQuantity;
  double price;

  ClothItem({
    required this.color,
    required this.sizeWithQuantity,
    required this.clothImageURL,
    required this.price,
  });
}
