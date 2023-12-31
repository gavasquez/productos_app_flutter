import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routerName = 'register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Crear Cuenta',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 30,
                ),

                // ChangeNotifierProvider se utiliza cuando tenemos solo un provider
                ChangeNotifierProvider(
                  // lo que hace es crear un instancia de LoginFormProvider que puede redibujar los widgets y solo va a estar _LoginForm
                  create: (_) => LoginFormProvider(),
                  // Formulario
                  child: const _LoginForm(),
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routerName);
              },
              child: const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )),
          const SizedBox(height: 50)
        ],
      ),
    )));
  }
}

// formulario
class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          // Mantener la referencia al key
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'gustavo.vasquez@gmail.com',
                    labelText: 'Correo Electronico',
                    prefixIcon: Icons.alternate_email_sharp),
                // se asigna el valor del value al provider
                onChanged: (value) => loginForm.email = value,
                // validaciones
                validator: (value) {
                  // expresion regular para la validación del correo
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  // toma la expresion regular si hace match con el value, eso va a regresar un valor bool
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '**********',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                // se asigna el valor del value al provider
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  // validamos si tiene algun valor y si es mayor a 6 caracteres
                  if (value != null && value.length >= 6) {
                    return null;
                  }
                  return 'La contraseña debe de ser 6 caracteres';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // button
              MaterialButton(
                // si el onPressed es null se desabilita el boton
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        // quitar el teclado
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        // Validar si el login es correcto
                        // se debe poner el listen: false porque estamos en un metodo
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routerName);
                        } else {
                          // Mostrar erro en pantalla
                          print(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere...' : 'Crear',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
