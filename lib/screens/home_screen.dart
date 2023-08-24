import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'home';

  @override
  Widget build(BuildContext context) {
    // Leemos el productsService
    final productsService = Provider.of<ProductsService>(context);
    // Mostramos el loading si esta en true
    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
      ),
      body: ListView.builder(
          // ponemos la cantidad de productos a la Lista
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: ProductCard(
                  // enviamos el argumento product
                  product: productsService.products[index],
                ),
                // cuando se le de clic Navegamos al ProductScreen
                onTap: () {
                  // se asigna selectProduct una copia del producto seleccionado
                  productsService.selectProduct = productsService.products[index].copy();
                  Navigator.pushNamed(context, ProductScreen.routerName);
                },
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
