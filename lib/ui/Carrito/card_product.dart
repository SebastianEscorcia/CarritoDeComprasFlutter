import 'package:flutter/material.dart';
import 'package:manejo_estado_con_get/models/product.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool showEdit; // Nuevo parámetro para controlar la edición

  const CardProduct({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
    this.showEdit = true, // Por defecto, el botón de editar se muestra
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // Acción al eliminar
        ),
        title: Text(product.name),
        subtitle: Text("Precio: \$${product.price}"),
        trailing: showEdit // Mostrar o no el botón de edición
            ? IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              )
            : null, // Si `showEdit` es falso, no se muestra nada
      ),
    );
  }
}
