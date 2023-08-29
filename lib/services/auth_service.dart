import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'AIzaSyA7yZySuHMwUKjYKHyUqMuVdIPB-CJhwp0';
  // Create storage
  final storage = new FlutterSecureStorage();

  // metodo para crear usuarios
  // si retornarmos algo es un error si no todo esta bien
  Future<String?> createUser(String email, String password) async {
    // Data que debemos enviar en la petición POST
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
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
      storage.write(key: 'token', value: decodedResp['idToken']);
      /* return decodedResp['idToken']; */
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    // Data que debemos enviar en la petición POST
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    // creación del Url
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      // Enviamos los header de la peticion, en esta ocación enviamos el key que es la llave de firebase
      'key': _fireBaseToken
    });
    // Disparamos la petición http
    final response = await http.post(url, body: json.encode(authData));
    // decodificamos la repuesta
    final Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp.containsKey('idToken')) {
      storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    // Delete value
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
