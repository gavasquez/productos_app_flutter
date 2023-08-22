import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  // se debe enviar el Widget
  final Widget child;
  // se declara en el constructor
  const AuthBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // es como una columna pero pone los widgets unos encima de otros
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          // se pone el widget que recibimos en el stack
          this.child
        ],
      ),
    );
  }
}

// Icono
class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

// Widget para el gradiente donde van las burbujas
class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // poner el tamaño del 40% de la pantalla
      height: size.height * 0.4,
      // gradiente
      decoration: _purpleBackground(),
      child: Stack(children: [
        Positioned(
          child: _Bubble(),
          top: 90,
          left: 30,
        ),
        Positioned(
          child: _Bubble(),
          top: -40,
          left: -30,
        ),
        Positioned(
          child: _Bubble(),
          top: -50,
          right: -20,
        ),
        Positioned(
          child: _Bubble(),
          bottom: -50,
          left: 10,
        ),
        Positioned(
          child: _Bubble(),
          bottom: 120,
          right: 20,
        )
      ]),
    );
  }

  BoxDecoration _purpleBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1)
    ]));
  }
}

// Burbujas
class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
