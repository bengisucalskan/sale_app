import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/base_page.dart';
import 'package:sale_app/modules/home/details/category_detail_view.dart';
import 'package:sale_app/modules/home/details/category_detail_view_model.dart';
import 'package:sale_app/modules/home/details/home_detail_view.dart';
import 'package:sale_app/modules/home/details/home_detail_view_model.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SaleApp();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'modules/home/details',
            builder: (BuildContext context, GoRouterState state) {
              final String category = state.extra as String;
              return ChangeNotifierProvider(
                create: (_) => CategoryDetailViewModel(paramCategory: category),
                child: const CategoryDetailView(),
              );
            },
          ),
          GoRoute(
            path: 'modules/home/details1',
            builder: (BuildContext context, GoRouterState state) {
              final String id = state.extra as String;
              return ChangeNotifierProvider(
                create: (_) => HomeDetailViewModel(paramId: id),
                child: const HomeDetailView(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
