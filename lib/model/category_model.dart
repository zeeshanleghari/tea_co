class CategoryModel {
  final int id;
  final String category;

  CategoryModel({required this.id, required this.category});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      category: json['category']?.toString() ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {'id': id, 'category': category};
  }
}
