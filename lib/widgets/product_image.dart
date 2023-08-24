import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: double.infinity,
          height: 450,
          decoration: _buildBoxDecoration(),
          // ClipRRect sirve agregar border redondeados a nuestros widgets internos
          child: const ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(45), topLeft: Radius.circular(45)),
            child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image:
                    NetworkImage('https://via.placeholder.com/400x300/green'),
                // para que se estire lo mas que pueda sin que pierda las dimenciones
                fit: BoxFit.cover),
          ),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);
}