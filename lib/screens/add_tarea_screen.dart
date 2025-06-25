import 'package:flutter/material.dart';

class AddTareaScreen extends StatelessWidget {
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final fechaController = TextEditingController();
  String categoria = 'P1';

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
                DropdownMenuItem(child: Text("Permanente 1"), value: 'P1'),
                DropdownMenuItem(child: Text("Permanente 2"), value: 'P2'),
                DropdownMenuItem(child: Text("Parcial"), value: 'PAR'),
                DropdownMenuItem(child: Text("Final"), value: 'FIN'),
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
