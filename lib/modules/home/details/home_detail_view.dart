import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/basket/cart_view.dart';
import 'package:sale_app/modules/basket/cart_view_model.dart';
import 'package:sale_app/modules/home/details/home_detail_view_model.dart';
import 'package:sale_app/modules/home/product_model.dart';
import 'package:sale_app/modules/profile/favorites_view_model.dart';

class HomeDetailView extends StatefulWidget {
  const HomeDetailView({super.key});

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeDetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.output_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CartView(),
                ));
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Consumer<HomeDetailViewModel>(
        builder: (context, vm, child) {
          return vm.loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          vm.productId.image ?? '',
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('£${vm.productId.price}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green,
                                  fontSize: 23,
                                )),
                            IconButton(
                                onPressed: () {
                                  if (context
                                      .read<FavoritesViewModel>()
                                      .isProductFavorite(vm.productId.id!)) {
                                    print(
                                        "${vm.productId}------aaaa-------- ${vm.productId.id}");
                                    context
                                        .read<FavoritesViewModel>()
                                        .removeItemFromFavorites(
                                            vm.productId.id!);
                                  } else {
                                    context
                                        .read<FavoritesViewModel>()
                                        .addItemFavorites(vm.productId);
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  // context.watch veriyi dinliyo veride değişiklik olursa widget build ediliyo.
                                  color: context
                                          .watch<FavoritesViewModel>()
                                          .isProductFavorite(vm.productId.id!)
                                      ? Colors.pink
                                      : Colors.grey,
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            vm.productId.title ?? "No title",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            vm.productId.description ?? "No description",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            vm.productId.description ?? "No description",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<HomeDetailViewModel>(builder: (context, vm, child) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      vm.decrease();
                    },
                  ),
                  Text('${vm.quantity}', style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      vm.increase();
                    },
                  ),
                ],
              );
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                fixedSize: Size(180, 34),
              ),
              onPressed: () {
                context
                    .read<CartViewModel>()
                    .addItem(vm.productId, vm.quantity);
              },
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
