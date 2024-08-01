import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 43,
          child: TextField(
            decoration: InputDecoration(
              filled: true, // kenar ekliyo

              fillColor: const Color.fromARGB(255, 234, 233, 241),
              prefixIcon: const Icon(Icons.search,
                  color: Color.fromARGB(255, 80, 76, 76)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide
                    .none, // kenar çizgisinin belirginliğini azaltıyor
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 33,
                        backgroundColor: Color.fromARGB(255, 218, 207, 207),
                      ),
                      Text(' aaaa')
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Text('Best Selling',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Sell all',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 450,
                width: double.infinity,
                child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                    }),
              )
            ],
          )
        ],
      )),
    );
  }
}
