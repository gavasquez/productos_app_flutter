import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  // mantener la referencia del formulario con el GlobalKey
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;
  // en el constructor se debe enviar un producto
  ProductFormProvider(this.product);

  // Validar el formulario
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // actualizar switch
  updateAvailability(bool value) {
    this.product.available = value;
    notifyListeners();
  }
}
