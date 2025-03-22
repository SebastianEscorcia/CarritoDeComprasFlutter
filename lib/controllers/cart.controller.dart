import 'package:get/get.dart';
import 'package:manejo_estado_con_get/models/product.dart';

class CartController extends GetxController {
  var cartProducts = <Product>[].obs;
  var mensaje = ''.obs;
  void addCart(Product product) => {
    if (cartProducts.any((productoBuscado) => productoBuscado == product))
      {mensaje.value = "El producto ya está en el carrito"}
    else
      {
        cartProducts.add(product),
        cartProducts.refresh(),
        mensaje.value = 'Producto agregado al carrito',
      },
  };
  void deleteProduct(Product product) {
    cartProducts.remove(product);
  }

  void clearCart() {
    cartProducts.clear();
    mensaje.value = "Carrito vacío"; // Mensaje de confirmación
  }

  int get itemCount => cartProducts.length;
}
