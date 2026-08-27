import 'package:tea_co/model/product_model.dart';

class CartModel {
  final String productId;
  int quantity;
  final ProductModel product;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.product,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['product_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}
