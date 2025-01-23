
class CategoryEntity{
  String label;
  String image;

  CategoryEntity({
    required this.label,
    required this.image
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json){
    return CategoryEntity(label: json['name'], image: json['image_url']);
  }
}