import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazyloading/config/config.dart';
import 'package:lazyloading/models/product_model.dart';
import 'package:lazyloading/models/user_model.dart';

class ApiService {
  Future<List<UserModel>> fetchUsers(int start, int limit) async {
    final response = await http.get(Uri.parse(baseUrl + usersEndpoint));
    // print('RESPONSE BODY: ${response.body}');
    final data = jsonDecode(response.body);
    print('FIRST ITEM: ${data.first}');
    print('ID TYPE: ${data.first['id'].runtimeType}');
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data
          .skip(start)
          .take(limit)
          .map((user) => UserModel.fromJson(json: user))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Product>> fetchProducts(int start, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl2$productsEndpoint?offset=$start&limit=$limit'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
