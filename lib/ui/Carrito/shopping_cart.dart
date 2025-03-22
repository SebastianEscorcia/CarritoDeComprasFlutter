import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manejo_estado_con_get/controllers/cart.controller.dart';
import 'package:manejo_estado_con_get/ui/Carrito/card_product.dart';
import 'package:manejo_estado_con_get/models/product.dart';

class CartShop extends StatelessWidget {
  final CartController cc = Get.find(); // Obtener la instancia de CartController

  CartShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carrito de Compras")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return cc.cartProducts.isEmpty
                  ? Center(
                      child: Text(
                        "El carrito está vacío",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cc.cartProducts.length,
                      itemBuilder: (context, index) {
                        Product product = cc.cartProducts[index];
                        return CardProduct(
                          product: product,
                          onDelete: () {
                            cc.deleteProduct(product);
                            Get.snackbar(
                              "Producto Eliminado",
                              "${product.name} fue eliminado del carrito",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(milliseconds: 800),
                            );
                          },
                          onEdit: () {}, // No se usa en el carrito, pero se mantiene por compatibilidad
                          showEdit: false, // Ocultar el botón de edición en CartShop
                        );
                      },
                    );
            }),
          ),
          Obx(() {
            return cc.cartProducts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        cc.clearCart(); // Vaciar el carrito
                        Get.snackbar(
                          "Pago exitoso",
                          "Gracias por tu compra. .",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                        );
                      },
                      child: Text('Pagar ${cc.cartProducts.fold(0.0, (suma, product) => suma + product.price)}'),
                    ),
                  )
                : SizedBox(); // Si el carrito está vacío, no mostrar el botón
          }),
        ],
      ),
    );
  }
}
