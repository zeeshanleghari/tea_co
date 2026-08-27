import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_co/model/cart_model.dart';
import 'package:tea_co/model/product_model.dart';

class CartController {
  final _supabase = Supabase.instance.client;

  String get _cartKey {
    final uuid = _supabase.auth.currentUser?.id;
    return uuid != null ? 'cart_$uuid' : "cart_guest";
  }

  // save list in sharedPreferences
  Future<void> _saveCart(List<CartModel> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final data = cart.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_cartKey, data);
  }

  // get Data from SharedPrefernece
  Future<List<CartModel>> fetchCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_cartKey) ?? [];
    return data.map((e) => CartModel.fromJson(jsonDecode(e))).toList();
  }

  // add / update Quantity
  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    final cart = await fetchCart();

    final index = cart.indexWhere((i) => i.productId == product.id);

    if (index != -1) {
      cart[index].quantity += quantity;
    } else {
      cart.add(
        CartModel(productId: product.id, quantity: quantity, product: product),
      );
    }
    return _saveCart(cart);
  }

  Future<void> removeFromCart(String productId) async {
    final cart = await fetchCart();

    cart.removeWhere((i) => i.productId == productId);
    await _saveCart(cart);
  }

  

  
}
