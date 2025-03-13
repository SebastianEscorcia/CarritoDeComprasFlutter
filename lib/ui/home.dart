import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:manejo_estado_con_get/ui/Carrito/list_product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: "Carrito de compra",
      debugShowCheckedModeBanner: false,
      home: ListProduct()
      
    );
  }
}