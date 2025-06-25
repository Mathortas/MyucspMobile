import 'package:flutter/material.dart';
import 'add_tarea_screen.dart';

class CursoDetalleScreen extends StatelessWidget {
  final tareas = [
    {'nombre': 'Tarea 1', 'fecha': '10/07/2025', 'estado': 'pendiente'},
    {'nombre': 'Prueba Parcial', 'fecha': '15/07/2025', 'estado': 'entregada'},
  ];

  @override
  Widget build(BuildContext context) {
    final entregadas = tareas.where((t) => t['estado'] == 'entregada').length;
    final progreso = (entregadas / tareas.length * 100).round();

    return Scaffold(
      appBar: AppBar(title: Text("Curso Detalle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progreso / 100),
            Text("Progreso: $progreso%"),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareas[index];
                  return Card(
                    child: ListTile(
                      title: Text(tarea['nombre']!),
                      subtitle: Text("Entrega: ${tarea['fecha']}"),
                      trailing: Text(tarea['estado']!),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Nueva tarea o prueba"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddTareaScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
