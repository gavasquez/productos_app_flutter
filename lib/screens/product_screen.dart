import 'package:flutter/material.dart';
import 'package:productos_app/providers/prodcut_form_provider.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const String routerName = 'product';
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Image
                ProductImage(url: productService.selectProduct.picture),
                // Icon de Voler
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        // volver a la pagina anterior
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),
                // Camara o galeria
                Positioned(
                    top: 60,
                    right: 30,
                    child: IconButton(
                        // Abrir camara o galeria
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        )))
              ],
            ),
            // formulario
            _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      // Cambiar de posicion el floatingActionButton
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Guardar producto
          },
          child: const Icon(Icons.save_outlined)),
    );
  }
}

// fomulario
class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        // padding interno
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        // contenido
        child: Form(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Nombre Producto
            TextFormField(
              initialValue: product.name,
              onChanged: (value) => product.name = value,
              validator: (value) {
                if (value == null || value.length < 1)
                  return 'El nombre es obligatorio';
              },
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del Producto', labelText: 'Nombre:'),
            ),
            const SizedBox(
              height: 30,
            ),
            // Precio
            TextFormField(
              initialValue: '${product.price}',
              onChanged: (value) {
                // Validamos si se puede parsear
                if (double.tryParse(value) == null) {
                  product.price = 0;
                } else {
                  product.price = double.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', labelText: 'Precio:'),
            ),
            const SizedBox(
              height: 30,
            ),
            // SWITCH
            SwitchListTile.adaptive(
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                value: product.available,
                onChanged: (value) {
                  product.available = value;
                }),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
