import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/basket/cart_view_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEPET'),
      ),
      body: Consumer<CartViewModel>(builder: (context, vm, child) {
        return ListView.builder(
          itemCount: vm.items.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      vm.items[index].product.image ?? "",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          vm.items[index].product.title ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        Provider.of<CartViewModel>(context, listen: false)
                            .decrementQuantity(index);
                      }),
                  Text('${vm.items[index].quantities}'),
                  IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Provider.of<CartViewModel>(context, listen: false)
                            .incrementQuantity(index);
                      }),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\£${(vm.items[index].quantities.toDouble() * (vm.items[index].product.price ?? 0.0)).toStringAsFixed(2)}', // miktar artışına göre değişiy
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Provider.of<CartViewModel>(context, listen: false)
                                .removeItem(index);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Price: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<CartViewModel>(builder: (context, vm, child) {
                  return Text(
                    '£${vm.totalPrice.toStringAsFixed(2)}', // 2 basamakla beraber metinsel formata çeviriyomuş
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  );
                }),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                fixedSize: const Size(180, 34),
              ),
              onPressed: () {
                // Sepeti onayla ksımı
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
