import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sale_app/modules/home/product_model.dart';

class CategoryDetailViewModel extends ChangeNotifier {
  CategoryDetailViewModel({required this.paramCategory}) {
    getProductsByCategory(paramCategory ?? "");
  }
  bool _loading = false;
  bool get loading => _loading;
  static const baseUrl = 'https://fakestoreapi.com/products/category/';

  List<Product> productCategories = List.empty(growable: true);
  final String? paramCategory;

  void getProductsByCategory(String category) async {
    changeLoading();
    try {
      var response = await Dio().get("$baseUrl$category");
      productCategories = (response.data as List)
          .map((item) => Product.fromJson(item))
          .toList();
      print(" productCategories------------------ ${productCategories}");
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      changeLoading();
    }
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
