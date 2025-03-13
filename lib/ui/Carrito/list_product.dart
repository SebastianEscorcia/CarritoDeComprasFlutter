import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:manejo_estado_con_get/controllers/cart.controller.dart';
import 'package:manejo_estado_con_get/controllers/product_controller.dart';
import 'package:manejo_estado_con_get/ui/Carrito/product_add.dart';
import 'package:manejo_estado_con_get/ui/Carrito/shopping_cart.dart';

class ListProduct extends StatelessWidget {
  final ProductController pc = Get.put(ProductController());
  final CartController cc = Get.put(CartController());

  ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        centerTitle: true,
        actions: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => Get.to(CartShop()),
                child: badges.Badge(
                  badgeContent: Text(
                    '${cc.itemCount}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  showBadge: cc.itemCount > 0,
                  child: const Icon(Icons.shopping_cart, size: 28),
                ),
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() {
              return Text(
                "Productos disponibles: ${pc.productCount.value}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              return pc.products.isEmpty
                  ? const Center(child: Text("No hay productos disponibles"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: pc.products.length,
                      itemBuilder: (context, index) {
                        final product = pc.products[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                '\$${product.price}',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: const Color.fromARGB(255, 255, 112, 68),
                                ),
                                onPressed: () {
                                  cc.addCart(product);
                                  Get.snackbar(
                                    "Carrito",
                                    cc.mensaje.value,
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(milliseconds: 800),
                                    backgroundColor:  const Color.fromARGB(255, 255, 112, 68).withOpacity(0.8),
                                    colorText: Colors.white,
                                  );
                                },
                                child: const Text("Añadir", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProduct());
        },
        backgroundColor: const Color.fromARGB(255, 255, 143, 68),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
