import 'package:flutter/material.dart';
import 'package:sale_app/core/init/network/base_service.dart';
import 'package:sale_app/features/home/model/product_model.dart';

class CategoryDetailViewModel extends ChangeNotifier {
  CategoryDetailViewModel({required this.paramCategory}) {
    getProductsByCategory(paramCategory ?? "");
  }
  bool _loading = false;
  bool get loading => _loading;

  List<Product> productCategories = List.empty(growable: true);
  final _service = BaseService();
  final String? paramCategory;

  void getProductsByCategory(String category) async {
    changeLoading();
    try {
      var response = await _service.get('products/category/$category');
      productCategories = (response.data as List).map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    } catch (e) {
      print("Hata");
    }
    changeLoading();
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
