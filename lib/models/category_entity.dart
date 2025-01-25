
class CategoryEntity{
  String label;
  String image;
  int id;

  CategoryEntity({
    required this.label,
    required this.image,
    required this.id,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json){
    return CategoryEntity(id: json['id'], label: json['name'], image: json['image_url']);
  }
}