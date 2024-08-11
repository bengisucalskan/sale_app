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
    print("Products in favorites before removal:");
    for (var item in favoriteItem) {
      print("Product ID: ${item.id}");
    }

    int initialCount = favoriteItem.length;
    favoriteItem.removeWhere((item) {
      bool shouldRemove = item.id == productId;
      print(
          "Checking product with ID ${item.id} against $productId: $shouldRemove");
      return shouldRemove;
    });
    int finalCount = favoriteItem.length;

    print("Products removed: ${initialCount - finalCount}");
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
