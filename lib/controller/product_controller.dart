import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_co/model/product_model.dart';

class ProductController {
  final supabase = Supabase.instance.client;

  Future<List<ProductModel>> getProducts() async {
    final response = await supabase.from('products').select('*, categories(*)');

    final data = response as List<dynamic>;
    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
