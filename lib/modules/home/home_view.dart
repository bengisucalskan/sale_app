import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/home/home_view_model.dart';

final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            filled: true, // kenar ekliyo
            fillColor: const Color.fromARGB(255, 234, 233, 241),
            prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 80, 76, 76)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none, // kenar çizgisinin belirginliğini azaltıyor
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<HomeViewModel>(
            builder: (context, value, child) => value.loading
                ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.categories.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  context.go(
                                    "/modules/home/details",
                                    extra: value.categories[index],
                                  );
                                  print("home_view------------------${value.categories[index]}");
                                },
                                child: const CircleAvatar(
                                  radius: 33,
                                  backgroundColor: Color.fromARGB(255, 218, 207, 207),
                                ),
                              ),
                              Text(value.categories[index] ?? "")
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.transparent, child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(vm.bestSelling,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('See all', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Consumer<HomeViewModel>(
            builder: (context, value, child) => value.loading
                ? GridView.extent(
                    childAspectRatio: 0.6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 1.1,
                    children: value.products
                        .map(
                          (e) => InkWell(
                              onTap: () {
                                context.go(
                                  "/modules/home/details1",
                                  extra: e.id.toString(),
                                );
                                print("home_view------------------${e.id}");
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Image.network(
                                        // CachedNetworkImage
                                        "${e.image}",
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.image),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      e.title ?? "",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900, fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      e.category ?? "",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          fontSize: 13),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          '£${e.price}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.green,
                                              fontSize: 19),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            // sepete ürün ekleyecek basınca
                                          },
                                          icon: Icon(Icons.shopping_cart_outlined))
                                    ],
                                  ),
                                ],
                              )),
                        )
                        .toList())
                : const CircleAvatar(
                    backgroundColor: Colors.transparent, child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
