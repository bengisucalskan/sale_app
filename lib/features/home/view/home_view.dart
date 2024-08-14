import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/core/extension/context_extension.dart';
import 'package:sale_app/features/home/vm/home_view_model.dart';

part 'circular_progress.dart';

final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
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
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              context.isMobile ? 'Categories' : 'Bengi',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _categoriesList(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Best Selling', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('See all', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _gridView()
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => value.loading
          ? SizedBox(
              height: context.isMobile ? 100 : 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.categories.length,
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
                          },
                          child: CircleAvatar(
                            radius: context.isMobile ? 33 : 66,
                            backgroundColor: const Color.fromARGB(255, 218, 207, 207),
                          ),
                        ),
                        Text(value.categories[index] ?? "")
                      ],
                    ),
                  );
                },
              ),
            )
          : const _CustomCircularProgress(),
    );
  }

  Widget _gridView() {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) => value.loading
          ? GridView.extent(
              childAspectRatio: 0.6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              maxCrossAxisExtent: context.isMobile ? context.width / 1.1 : context.width / 2.2,
              children: value.products
                  .map(
                    (e) => InkWell(
                        onTap: () {
                          context.go(
                            "/modules/home/details1",
                            extra: e.id.toString(),
                          );
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
                            _gridViewItemTexts(
                              text: '${e.title}',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                            ),
                            _gridViewItemTexts(
                                text: '${e.category}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 13)),
                            _gridViewItemTexts(
                                text: '${e.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.green,
                                    fontSize: 19)),
                          ],
                        )),
                  )
                  .toList())
          : const _CustomCircularProgress(),
    );
  }

  Widget _gridViewItemTexts({String? text, TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
