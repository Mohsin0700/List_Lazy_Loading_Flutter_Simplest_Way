import 'package:flutter/material.dart';
import 'package:lazyloading/api_service.dart';
import 'package:lazyloading/models/product_model.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  final List<Product> _products = [];
  int start = 0;
  int limit = 10;
  bool isLoading = false;
  bool hasMoreProducts = true;

  @override
  void initState() {
    super.initState();
    fetchMoreProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreProducts();
      }
    });
  }

  Future<void> fetchMoreProducts() async {
    if (isLoading || !hasMoreProducts) return;
    setState(() {
      isLoading = true;
    });

    List<Product> newProducts = await _apiService.fetchProducts(start, limit);

    setState(() {
      _products.addAll(newProducts);
      start += limit;
      isLoading = false;
      if (newProducts.length < limit) {
        hasMoreProducts = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [Text(_products.length.toString())],
      ),
      body: SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: _products.length + (hasMoreProducts ? 1 : 0),
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index < _products.length) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                height: 200,
                width: 200,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        textAlign: TextAlign.center,
                        _products[index].title ?? "No Title",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.network(_products[index].images![0], height: 150),
                    ],
                  ),
                ),
              );
            } else {
              return isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
