import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

// creamos un StatelessWidget donde ponemos MultiProvider y en los providers ponemos todos los providers que vamos a usar en nuestra aplicacion
// y se pone como child MyApp y con eso ponemos nuestro providers en el punto mas alto de la aplicacion
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => ProductsService())
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      /* initialRoute: LoginScreen.routerName, */
      initialRoute: LoginScreen.routerName,
      routes: {
        LoginScreen.routerName: (_) => LoginScreen(),
        HomeScreen.routerName: (_) => HomeScreen(),
        ProductScreen.routerName: (_) => ProductScreen(),
        RegisterScreen.routerName: (_) => RegisterScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          // estilos del appBar
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
          // estilos del floatingActionButton
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
