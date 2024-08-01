import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sale_app/categories_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    print('başlatt');
    getCategories();
  }
  bool _loading = false;
  bool get loading => _loading;

  final dio = Dio();

  static const base_url = "'https://fakestoreapi.com/";

  //List<Categories> categories = List.empty(growable: true);

  List<String> categories = List.empty(growable: true);

  void getCategories() async {
    print(' func started');
    final response = await dio.get('${base_url}categories');
    if (response.statusCode == 200) {
      print('response data = ${response.data}');
      categories = response.data;
    }

    changeLoading();
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
