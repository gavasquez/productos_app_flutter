import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-44595-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  // product seleccionado
  late Product selectProduct;
  bool isLoading = true;

  // Constructor
  ProductsService() {
    loadProducts();
  }
  // TODO: <List<Product>>
  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    // esperamos la petición
    final resp = await http.get(url);
    // Convertir la respuesta
    // Decoficamos la respuesta
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    // Barremos las llaves que tiene el Map
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      // se asigna al id de tempPorduct la llave del Map
      tempProduct.id = key;
      // agregamos el tempProduct a la Lista de products
      this.products.add(tempProduct);
    });
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }
}
