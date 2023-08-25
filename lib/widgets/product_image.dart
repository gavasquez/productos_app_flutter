import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: double.infinity,
          height: 450,
          decoration: _buildBoxDecoration(),
          // dar opacidad al color de fondo
          child: Opacity(
            opacity: 0.9,
            // ClipRRect sirve agregar border redondeados a nuestros widgets internos
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(45), topLeft: Radius.circular(45)),
              // Validar la imagen
              child: this.url == null
                  ? const Image(
                      image: AssetImage('assets/no-image.png'),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      image: NetworkImage(this.url!),
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      // para que se estire lo mas que pueda sin que pierda las dimenciones
                      fit: BoxFit.cover),
            ),
          ),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);
}
