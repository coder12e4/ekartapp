import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/Models/ProductModel.dart';

part 'kart_state.dart';

class KartCubit extends Cubit<KartState> {
  int _cartCount = 0;
  KartCubit() : super(KartInitial());
  int get cartCount => _cartCount;

  Future<void> _loadCartCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cart') ?? [];
    _cartCount = cartList.length;
    emit(KartInitial());
  }

  Future<void> addToCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cart') ?? [];

    // Check if the product already exists in the cart
    bool productExists = cartList.any((item) {
      final cartItem = ProductModel.fromJson(jsonDecode(item));
      return cartItem.id == product.id;
    });

    if (!productExists) {
      cartList.add(jsonEncode(product.toJson()));
      await prefs.setStringList('cart', cartList);
      _cartCount = cartList.length;
      emit(KartSuccess(
          cartList.map((e) => ProductModel.fromJson(jsonDecode(e))).toList()));
    } else {
      emit(KartFail(cartList
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList()
          .length
          .toString()));
    }
  }

  Future<void> displayCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cart') ?? [];
    _cartCount = cartList.length;
    emit(KartSuccessWithLenth(
        cartList.map((e) => ProductModel.fromJson(jsonDecode(e))).toList()));
  }

  Future<void> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cart') ?? [];
    _cartCount = cartList
        .map((e) => ProductModel.fromJson(jsonDecode(e)))
        .toList()
        .length;
  }

  Future<void> removeFromCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      List<String> cartList = prefs.getStringList('cart') ?? [];

      cartList.removeWhere((item) {
        final cartItem = ProductModel.fromJson(jsonDecode(item));
        return cartItem.id == product.id;
      });

      await prefs.setStringList('cart', cartList);
      _cartCount = cartList.length;
      emit(KartSuccess(
          cartList.map((e) => ProductModel.fromJson(jsonDecode(e))).toList()));
    } catch (e) {
      print(e);
    }
  }
}
