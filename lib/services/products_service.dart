import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-products-bb4e2-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }
//
  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }
}
