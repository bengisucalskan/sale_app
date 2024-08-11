import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/profile/favorites_view_model.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favoriler'),
        ),
        body: Consumer<FavoritesViewModel>(builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.favoriteItem.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      vm.favoriteItem[index].image ?? "",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(vm.favoriteItem[index].title ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      Text('${vm.favoriteItem[index].price}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ],
                  )),
                  IconButton(
                      onPressed: () {
                        context
                            .read<FavoritesViewModel>()
                            .removeItemFromFavorites(
                                vm.favoriteItem[index].id!);
                      },
                      icon: Icon(Icons.delete))
                ],
              ));
            },
          );
        }));
  }
}
