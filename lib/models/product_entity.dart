class productEntity {
  int id;
  String productName;
  String description;
  int price;
  int quantity;
  int? weight;
  String categoryName;
  String imageUrl;

  productEntity({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    this.weight,
    required this.categoryName,
    required this.imageUrl
  });

  factory productEntity.fromJson(Map<String, dynamic> json) {
    return productEntity(
        id: json['id'],
        productName: json['name'],
        description: json['description'],
        price: json['price'],
        quantity: json['quantity'],
        weight: json['weight'],
        categoryName: json['category_name'],
        imageUrl: json['image_url']
    );
  }
}