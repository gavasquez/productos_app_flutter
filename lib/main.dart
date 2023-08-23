import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      /* initialRoute: LoginScreen.routerName, */
      initialRoute: HomeScreen.routerName,
      routes: {
        LoginScreen.routerName: (_) => LoginScreen(),
        HomeScreen.routerName: (_) => HomeScreen()
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
