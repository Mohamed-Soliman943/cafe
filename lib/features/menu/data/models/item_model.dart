class ItemModel {
  final String title;
  final String description;
  final List<String> ingredients;
  final String image;
  final int id;

  ItemModel({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.id,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      ingredients: json['ingredients'] is List
          ? List<String>.from(json['ingredients'])
          : const [],
      image: json['image']?.toString() ?? '',
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'image': image,
      'id': id,
    };
  }
}