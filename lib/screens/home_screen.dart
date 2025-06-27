import 'package:flutter/material.dart';
import 'curso_detalle_screen.dart';
import 'calendario_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final cursos = [
    'Añadir curso',
    'Desarrollo Basado en Plataformas',
    'Cálculo II',
    'Arquitectura de Computadores',
    'Apreciación Artística',
    'CCOMP II'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis cursos'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => CalendarioScreen())),
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: cursos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (ctx, i) {
            final title = cursos[i];
            final isAdd = (i == 0);
            return GestureDetector(
              onTap: () {
                if (!isAdd) Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CursoDetalleScreen())
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isAdd ? Colors.grey[200] : Colors.primaries[i % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isAdd ? Colors.black54 : Colors.white,
                      fontSize: isAdd ? 24 : 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

