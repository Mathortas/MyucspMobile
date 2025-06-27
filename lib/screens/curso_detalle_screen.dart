import 'package:flutter/material.dart';
import 'add_tarea_screen.dart';

class CursoDetalleScreen extends StatelessWidget {
  final pendientes = [
    'Entrega de ejemplo de Soneto clásico',
    'Trabajo en grupo de investigación',
    'Registrarse en la obra de teatro municipal',
  ];
  final entregadas = [
    'Indagar respecto al arte contemporáneo',
    '15 pinturas mundialmente conocidas',
    'Trabajo grupal de primera mitad de semestre',
  ];
  final evalPend = [
    'Control III',
    'Control de lectura II',
  ];
  final evalHechas = [
    'Control I (13)',
    'Parcial (15)',
    'Control de lectura I (17)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apreciación Artística')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection('Tareas pendientes', pendientes, Colors.yellow[100]!),
            _buildSection('Tareas entregadas', entregadas, Colors.green[100]!),
            _buildSection('Evaluaciones pendientes', evalPend, Colors.purple[100]!),
            _buildSection('Evaluaciones hechas', evalHechas, Colors.blue[100]!),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Agregar'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddTareaScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, Color bg) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold)),
          ...items.map((i) => Text('• $i')).toList(),
        ],
      ),
    );
  }
}

