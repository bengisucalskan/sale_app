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

  /*void addItem(Product product, int quantity) {
    for (var element in _items) {
      if (element.product.id != product.id) {
        _items.add(CartItem(product: product, quantities: quantity));
      } else {
        element.quantities = quantity;
      }
    }

    print('ürün eklendi');
  } */
  // eğer sepette iki farklı ürün varsa aynı ürünlenden bir tane daha eklersek
  //döngüden dolayı f<rklı olanla id si uyuşmuyo ve sepette aynı üründen iki tane farklı eklenir.

  void addItem(Product product, int quantity) {
    bool itemExists = false;

    for (var element in _items) {
      if (element.product.id == product.id) {
        // Ürün sepette varsa miktar artsın ÇALIŞMIYO nedeni homedetailviewdaki increase metodları
        //  olabilir mi??
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
    notifyListeners();
    print('ürün eklendi');
  }

  double getTotalPrice() {
    //voide çevir
    double total = 0;
    for (var item in _items) {
      total += item.quantities * (item.product.price ?? 0.0);
    }
    return total;
  }

  void changeLoading() {
    _loading = !_loading;
    notifyListeners();
  }
}
