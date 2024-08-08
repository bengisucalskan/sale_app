import 'package:sale_app/modules/home/product_model.dart';
import 'package:flutter/material.dart';

class CartItem {
  Product product;
  int quantities;
  CartItem({required this.product, required this.quantities});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  bool _loading = false;
  bool get loading => _loading;
  double get totalPrice => _totalPrice;

  double _totalPrice = 0.0;

  void addItem(Product product, int quantity) {
    bool itemExists = false;

    for (var element in _items) {
      if (element.product.id == product.id) {
        // Ürün sepette varsa miktar artsın
        element.quantities += quantity;
        itemExists = true;
        notifyListeners();
        break;
      }
    }
    // ürün sepette yoksa eklesin çalışıyo
    if (!itemExists) {
      _items.add(CartItem(product: product, quantities: quantity));
    }
    _getTotalPrice();
    notifyListeners();
    print('ürün eklendi');
  }

  void incrementQuantity(int index) {
    _items[index].quantities++;
    _getTotalPrice();
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantities > 1) {
      _items[index].quantities--;
      _getTotalPrice();
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _getTotalPrice();
    notifyListeners();
  }

  void _getTotalPrice() {
    //voide çevir+  , counter detay sayfasında da artsın!!, silme tuşunu yap, favoriler sayfasını yap!!!,git branch öğren
    _totalPrice = 0;
    for (var item in _items) {
      _totalPrice += item.quantities * (item.product.price ?? 0.0);
    }
    notifyListeners();
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
