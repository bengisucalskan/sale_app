import 'package:flutter/material.dart';
import 'package:sale_app/core/init/cache/locale_manager.dart';
import 'package:sale_app/core/init/network/base_service.dart';
import 'package:sale_app/features/home/model/product_model.dart';

class HomeDetailViewModel extends ChangeNotifier {
  HomeDetailViewModel({required this.paramId}) {
    getProductsById(paramId ?? "");
  }
  bool _loading = false;
  bool get loading => _loading;
  Product productId = Product();
  int quantity = 0;
  final _service = BaseService();

  final String? paramId;

  void getProductsById(String id) async {
    changeLoading();
    try {
      var response = await _service.get('products/$id');
      productId = Product.fromJson(response.data);
      quantity = LocaleManager.instance.getIntValue(productId.id.toString());
      notifyListeners();
    } catch (e) {
      print('Hata $e');
    } finally {
      changeLoading();
      notifyListeners();
    }
  }

  void increase() async {
    quantity++;
    notifyListeners();
  }

  void decrease() async {
    if (quantity > 0) {
      quantity--;
      notifyListeners();
    }
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
