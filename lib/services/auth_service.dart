import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'AIzaSyA7yZySuHMwUKjYKHyUqMuVdIPB-CJhwp0';

  // metodo para crear usuarios
  // si retornarmos algo es un error si no todo esta bien
  Future<String?> createUser(String email, String password) async {
    // Data que debemos enviar en la petición POST
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    // creación del Url
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      // Enviamos los header de la peticion, en esta ocación enviamos el key que es la llave de firebase
      'key': _fireBaseToken
    });
    // Disparamos la petición http
    final response = await http.post(url, body: json.encode(authData));
    // decodificamos la repuesta
    final Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp.containsKey('idToken')) {
      // Grabar el token en un lugar seguro
      /* return decodedResp['idToken']; */
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }
}
