import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/home/details/home_detail_view_model.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeDetailViewModel viewModel = context.read<HomeDetailViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Consumer<HomeDetailViewModel>(builder: (context, vm, child) {
          return Text(vm.paramCategory ?? "",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        }),
      ),
      body: Consumer<HomeDetailViewModel>(
        builder: (context, vm, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: vm.productCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        vm.productCategories[index].image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        vm.productCategories[index].title ?? "No title",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Text('£${vm.productCategories[index].price}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                          fontSize: 19,
                        )),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
