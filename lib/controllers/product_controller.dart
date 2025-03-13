import 'package:get/get.dart';
import 'package:manejo_estado_con_get/controllers/cart.controller.dart';
import 'package:manejo_estado_con_get/models/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var mensaje = ''.obs;
  var productCount = 0.obs; // Contador de productos disponibles
  // SI SE COLOCA FIND SE ESTALLA 
  final CartController cc = Get.put(CartController());
  @override
  void onInit() {
    products.addAll([
      Product(name: 'Salchipapa Salvaje', price: 25000),
      Product(name: "Perro caliente", price: 10000),
    ]);
    productCount.value = products.length; // Inicializar el contador
    super.onInit();
  }

  void addProduct(String name, double price) {
    if (products.any((Product product) => product.name == name)) {
      mensaje.value = 'Este producto ya existe';
    } else if (name == '' || price <= 0) {
      mensaje.value = 'No has indicado el nombre o el precio no es válido';
    } else {
      products.add(Product(name: name, price: price));
      productCount.value = products.length; // Actualizar contador
      mensaje.value = 'Producto agregado correctamente';
    }
  }

  void deleteProduct(Product product) {
    if (products.contains(product)) {
      products.remove(product);
      productCount.value = products.length; 
      //Remover producto una vez quitemos también desde administrar nuestros productos
      if (cc.cartProducts.contains(product)) {
        cc.cartProducts.remove(product);
      }
      
      if (productCount.value == 0) {
        mensaje.value = 'No hay productos disponibles';
      }
    } else {
      mensaje.value = 'No se puede eliminar el producto';
    }
  }

  void editProduct(Product oldProduct, String newName, double newPrice) {
    int index = products.indexOf(oldProduct);
    if (index != -1) {
      products[index] = Product(name: newName, price: newPrice);
      products.refresh(); // Para que GetX reconozca el cambio
      mensaje.value = 'Producto actualizado';
    } else {
      mensaje.value = 'No se pudo actualizar el producto';
    }
  }
}
