import 'package:flutter/material.dart';
import 'package:sale_app/modules/home/product_model.dart';

class FavoritesViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<Product> favoriteItem = [];

  void addItemFavorites(Product product) {
    if (!favoriteItem.any((item) => item.id == product.id)) {
      favoriteItem.add(product);
      notifyListeners();
    }
  }

  void removeItemFromFavorites(int productId) {
    favoriteItem.removeWhere((item) {
      bool remove = item.id == productId;
      print("Checking product  ID ${item.id} against $productId: $remove");
      return remove;
    });

    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
