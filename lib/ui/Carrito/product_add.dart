import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:manejo_estado_con_get/controllers/product_controller.dart';
import 'package:manejo_estado_con_get/models/product.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController txtName = TextEditingController();
    final TextEditingController txtPrice = TextEditingController(text: "0");
    final ProductController pc = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrar Productos"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() {
              return badges.Badge(
                badgeContent: Text(
                  '${pc.productCount.value}',
                  style: const TextStyle(color: Colors.white),
                ),
                showBadge: pc.productCount.value > 0,
                child: const Icon(Icons.shopping_bag, size: 28),
              );
            }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                labelText: "Ingresar Nombre",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: txtPrice,
              decoration: InputDecoration(
                labelText: "Ingrese el precio",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 112, 68),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                pc.addProduct(txtName.text, double.tryParse(txtPrice.text) ?? 0);
                Get.defaultDialog(
                  title: 'Aviso',
                  middleText: pc.mensaje.value,
                  textConfirm: "OK",
                  onConfirm: () => Get.back(),
                  confirmTextColor: Colors.white,
                  buttonColor: const Color.fromARGB(255, 255, 112, 68),
                );
              },
              child: const Text("Adicionar", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => pc.products.isEmpty
                    ? const Center(child: Text("No hay productos disponibles"))
                    : ListView.builder(
                        itemCount: pc.products.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text(pc.products[index].name),
                              subtitle: Text("Precio: \$${pc.products[index].price}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color:  Color.fromARGB(255, 255, 112, 68)),
                                    onPressed: () {
                                      _showEditDialog(context, pc, pc.products[index]);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      pc.deleteProduct(pc.products[index]);
                                      Get.snackbar(
                                        "Producto Eliminado",
                                        "Se eliminó ${pc.products[index].name}",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: const Duration(milliseconds: 850),
                                        backgroundColor: Colors.redAccent.withOpacity(0.8),
                                        colorText: Colors.white,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProductController pc, Product product) {
    TextEditingController nameController = TextEditingController(text: product.name);
    TextEditingController priceController = TextEditingController(text: product.price.toString());

    Get.defaultDialog(
      title: "Editar Producto",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: "Precio"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: "Guardar",
      onConfirm: () {
        double? newPrice = double.tryParse(priceController.text);
        if (newPrice != null) {
          pc.editProduct(product, nameController.text, newPrice);
          Get.back();
        }
      },
      textCancel: "Cancelar",
    );
  }
}
