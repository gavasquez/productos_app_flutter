import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola HomeScreen'),
      ),
    );
  }
}
