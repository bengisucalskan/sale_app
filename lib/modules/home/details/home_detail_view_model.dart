import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sale_app/modules/home/product_model.dart';

class HomeDetailViewModel extends ChangeNotifier {
  HomeDetailViewModel({required this.paramId}) {
    getProductsById(paramId ?? "");
  }
  bool _loading = false;
  bool get loading => _loading;
  static const baseUrl = 'https://fakestoreapi.com/products/';
  Product productId = Product();
  int _quantity = 0;
  int get quantity => _quantity;

  final String? paramId;

  void getProductsById(String id) async {
    changeLoading();
    try {
      var response = await Dio().get("$baseUrl$id");
      productId = Product.fromJson(response.data);
      print(" productId------------------ ${productId}");
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      changeLoading();
    }
    notifyListeners();
  }

  void increase() {
    _quantity++;
    notifyListeners();
  }

  void decrease() {
    if (_quantity > 0) {
      _quantity--;
    }
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
