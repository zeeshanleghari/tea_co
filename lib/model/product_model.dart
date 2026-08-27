import 'package:tea_co/model/category_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final CategoryModel? category;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['categories'] != null
          ? CategoryModel.fromJson(json['categories'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'price': price,
      'categories': category?.toJson(),
    };
  }
}
