import 'package:flutter/material.dart';

class AddTareaScreen extends StatelessWidget {
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final fechaController = TextEditingController();
  String categoria = 'P1';

  AddTareaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Tarea o Prueba")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(labelText: 'Fecha de entrega (dd/mm/yyyy)'),
            ),
            DropdownButtonFormField<String>(
              value: categoria,
              onChanged: (value) => categoria = value!,
              items: [
                DropdownMenuItem(value: 'P1', child: Text("Permanente 1")),
                DropdownMenuItem(value: 'P2', child: Text("Permanente 2")),
                DropdownMenuItem(value: 'PAR', child: Text("Parcial")),
                DropdownMenuItem(value: 'FIN', child: Text("Final")),
              ],
              decoration: InputDecoration(labelText: "Categoría"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}
