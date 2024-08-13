import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sale_app/modules/home/product_model.dart';

class CartItem {
  Product product;
  int quantities;
  CartItem({required this.product, required this.quantities});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  bool _loading = false;
  bool get loading => _loading;

// gidiyor item-id ile product.id si eşit olan cartitem da bir eleman varsa bunun indexini alıyor.
//bu index varsa(-1!) ürünün miktarı güncellenir bu şekilde aynı ürün tekrar eklenmicek
  void addProduct(Product product, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantities = quantity;
    } else {
      _items.add(CartItem(
          product: product,
          quantities: quantity)); // sepette  yoksa ekle çalışıyo
    }
    await prefs.setInt(product.id.toString(), quantity);
    _getTotalPrice();
    notifyListeners();
  }

  void incrementQuantity(int index) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); // bunu basee e nasıl çekeilirim?
    _items[index].quantities++;
    await prefs.setInt(
        _items[index].product.id.toString(), _items[index].quantities);
    _getTotalPrice();
    notifyListeners();
  }

  void decrementQuantity(int index) async {
    if (_items[index].quantities > 1) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _items[index].quantities--;
      await prefs.setInt(
          _items[index].product.id.toString(), _items[index].quantities);
      _getTotalPrice();
      notifyListeners();
    }
  }

  void removeItem(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_items[index].product.id.toString());
    _items.removeAt(index);
    _getTotalPrice();
    notifyListeners();
  }

  void _getTotalPrice() {
    _totalPrice = 0.0;
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
