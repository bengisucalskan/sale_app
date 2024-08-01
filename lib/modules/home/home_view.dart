import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/modules/home/home_view_model.dart';

class HomeView extends StatelessWidget {
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
                              const CircleAvatar(
                                radius: 33,
                                backgroundColor: Color.fromARGB(255, 218, 207, 207),
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
                const Text('Sell all', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                mainAxisExtent: 130,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: const Color.fromARGB(255, 50, 51, 51),
                      ),
                      const SizedBox(height: 5),
                      const Text('aa'),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
