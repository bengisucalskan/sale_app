import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/home/details/category_detail_view_model.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CategoryDetailViewModel>(builder: (context, vm, child) {
          return Text(vm.paramCategory ?? "",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        }),
      ),
      body: Consumer<CategoryDetailViewModel>(
        builder: (context, vm, child) {
          return vm.loading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: vm.productCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          context.go(
                            "/modules/home/details1",
                            extra: vm.productCategories[index].id.toString(),
                          );
                          print(
                              "category_detail_view------------------${vm.productCategories[index].id.toString()}");
                        },
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
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
