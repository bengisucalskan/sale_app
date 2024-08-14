import 'package:flutter/material.dart';
import 'package:sale_app/core/init/network/base_service.dart';
import 'package:sale_app/features/home/model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getCategories();
    getProducts();
  }

  final _service = BaseService();

  String bestSelling = "Best Sellingg";
  bool _loading = false;
  bool get loading => _loading;

  List<dynamic> categories = List.empty(
      growable:
          true); //jsonserial, jsonannotion, equatable ile modelleri daha performanslı hale getirebiliriz.

  void getCategories() async {
    final response = await _service.get('products/categories');
    if (response.statusCode == 200) {
      categories = response.data;
    }
    changeLoading();
    notifyListeners();
  }

  List<Product> products = List.empty(growable: true);

  void getProducts() async {
    final List<String?> productCategories = List.empty(growable: true);
    String category = "";
    changeLoading();
    final response = await _service.get('products');
    if (response.statusCode == 200) {
      List<dynamic> productData = response.data;
      products = productData.map((e) => Product.fromJson(e)).toList();
      for (var e in products) {
        if (e.category != category) {
          productCategories.add(e.category);
          category = e.category ?? "";
        }
      }
    }
    changeLoading();
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
