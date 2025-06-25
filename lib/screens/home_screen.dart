import 'package:flutter/material.dart';
import 'curso_detalle_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> cursos = [
    {'nombre': 'Cálculo I', 'ciclo': '2024-I'},
    {'nombre': 'Base de Datos', 'ciclo': '2024-I'},
    {'nombre': 'Ética Profesional', 'ciclo': '2024-I'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Cursos')),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cursos[index]['nombre']!),
            subtitle: Text("Ciclo: ${cursos[index]['ciclo']}"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CursoDetalleScreen()));
            },
          );
        },
      ),
    );
  }
}
