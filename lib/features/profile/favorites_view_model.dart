import 'package:flutter/material.dart';
import 'package:sale_app/features/home/model/product_model.dart';

class FavoritesViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Product> favoriteItems = [];

  bool get loading => _loading;

  List<Product> get favoriteItem => favoriteItems;
//sepete ekle tuşunda snackbar silerken ise dialog gösterilecek

  // Ürünü kontrol et favorimi diye . Butona tıklandığında item.id ile produck.id si eşit olan
  // favoritsItemda herhangi bir item var mı varsa eğer home_detail_view sayfasına
  // git remove a gel
  bool isProductFavorite(int productId) {
    return favoriteItems.any((item) => item.id == productId);
  }

  void addItemFavorites(Product product) {
    favoriteItems.add(product);
    notifyListeners();
  }

  void removeItemFromFavorites(int productId) {
    // removeWhere listede bu özelliği sağalyan tüm nesneleri kaldırıyo
    favoriteItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void changeLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
