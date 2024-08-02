import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sale_app/modules/home/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    print('başlatt');
    getCategories();
    getProducts();
  }

  String bestSelling = "Best Sellingg";
  bool _loading = false;
  bool get loading => _loading;

  final dio = Dio();

  static const base_url = 'https://fakestoreapi.com/';

  //List<Categories> categories = List.empty(growable: true);

  List<dynamic> categories = List.empty(growable: true);

  void getCategories() async {
    print(' func started');
    final response = await dio.get('${base_url}products/categories');
    if (response.statusCode == 200) {
      print('response data = ${response.data}');
      categories = response.data;
    }
    changeLoading();
    notifyListeners();
  }

  List<Product> products = List.empty(growable: true);

  void getProducts() async {
    print('product func started');
    changeLoading();
    final response = await dio.get('${base_url}products');
    if (response.statusCode == 200) {
      List<dynamic> productData = response.data;
      products = productData.map((e) => Product.fromJson(e)).toList();
    }
    changeLoading();
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
