import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/base_page.dart';
import 'package:sale_app/home_view.dart';
import 'package:sale_app/home_view_model.dart';

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
      ],
      child: const MaterialApp(home: HomeView()),
    );
  }
}
