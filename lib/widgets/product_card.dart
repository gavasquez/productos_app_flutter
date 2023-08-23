import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding horizontal cal container para que no quede pegado
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        // top es arriba, bottom es abajo
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        // decoracion
        decoration: _cardBordes(),
        // va a tener unos hijos y se pone en el stack porque vamos a poner widgets unos encima de otros
        child: Stack(
          // se alinea en la parte de abajo
          alignment: Alignment.bottomLeft,
          children: [
            // Imagenes
            _BackgroundImage(),
            // Detalle del Producto
            _ProductDetails(),
            // Precio Tag
            Positioned(top: 0, right: 0, child: _PriceTag()),
            // Disponibilidad, Mostrar de manera condicional
            Positioned(top: 0, left: 0, child: _NotAvailable())
          ],
        ),
      ),
    );
  }

  // Borders y color a la tarjeta
  BoxDecoration _cardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          // Sombrea
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // adaptar el contenido
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }
}

class _PriceTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // FittedBox sirve para que se adapte el widget que esta adentro
      child: FittedBox(
        // para que se adapte el texto
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$103.994',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      // Alinear al centro
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // crear una separacion a la derecha
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: const Column(
          // mainAxisAlignment es vertical en un columna
          // crossAxisAlignment es horizontal en una columna
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disco Duro G',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              // solo una linea
              maxLines: 1,
              // si llega a ser muy largo ponga ...
              overflow: TextOverflow.ellipsis,
            ),
            Text('Id del Disco Duro',
                style: TextStyle(fontSize: 15, color: Colors.white))
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      // BorderRadies en la parte de abajo izquierda y parte de arriba a la derecha tambien
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: const FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          // adaptar la imagen
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
