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
  bool isSaving = false;

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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
      // ES necesario crear
      await createdProducto(product);
    } else {
      // Actualizar
      await updateProducto(product);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProducto(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toRawJson());
    final decodedData = resp.body;
    // Actualizar el listado de prodcutos
    final index = products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> createdProducto(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toRawJson());
    // convertimos la respuesta a un mapa, porque viene de tipo string
    final decodedData = json.decode(resp.body);
    // decodedData['name'] aca viene el id que pone firebase
    // se le agrega el id al producto
    product.id = decodedData['name'];
    // se agrega a products el product
    this.products.add(product);
    return product.id!;
  }
}
