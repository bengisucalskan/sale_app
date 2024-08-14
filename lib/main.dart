import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/core/init/di.dart';
import 'package:sale_app/core/init/route/router.dart';
import 'package:sale_app/features/basket/cart_view_model.dart';
import 'package:sale_app/features/home/vm/home_view_model.dart';
import 'package:sale_app/features/profile/favorites_view_model.dart';

Future<void> main() async {
  await Di.init();
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
