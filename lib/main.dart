import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/base/init/router.dart';
import 'package:sale_app/modules/basket/cart_view_model.dart';
import 'package:sale_app/modules/home/home_view_model.dart';
import 'package:sale_app/modules/profile/favorites_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
      ],
      child: MaterialApp.router(
        routerConfig: Routes.router,
      ),
    );
  }
}
