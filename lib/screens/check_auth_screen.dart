import 'package:flutter/material.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routerName = 'checking';
  @override
  Widget build(BuildContext context) {
    // Como no necesitamos redbujar se pone el listen:false
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // Si no tiene data
              if (!snapshot.hasData) {
                return Text('Espere');
              }
              // Si no tiene el token lo sacamos al Login
              if (snapshot.hasData == '') {
                // El builder debe de regresar un widget no se puede hacer un navigator
                Future.microtask(() {
                  // Crear transición manual
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              } else {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomeScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              }
              return Container();
            }),
      ),
    );
  }
}
