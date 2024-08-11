import 'package:flutter/material.dart';
import 'package:sale_app/modules/basket/cart_view.dart';
import 'package:sale_app/modules/home/home_view.dart';
import 'package:sale_app/modules/profile/favorites_view.dart';

class SaleApp extends StatefulWidget {
  const SaleApp({super.key});

  @override
  State<SaleApp> createState() => _SaleAppState();
}

class _SaleAppState extends State<SaleApp> {
  Widget _navigateTo() {
    switch (currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const CartView();
      case 2:
        return const FavoritesView();
    }
    return const HomeView();
  }

  Map<int, bool> itemStatus = {};

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _navigateTo(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_flags_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined),
              label: '',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ));
  }
}
