// lib/screens/curso_detalle_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_tarea_screen.dart';

class CursoDetalleScreen extends StatefulWidget {
  final int cursoId;

  // Constructor marcado como const y con Key opcional
  const CursoDetalleScreen({
    Key? key,
    required this.cursoId,
  }) : super(key: key);

  @override
  _CursoDetalleScreenState createState() => _CursoDetalleScreenState();
}

class _CursoDetalleScreenState extends State<CursoDetalleScreen> {
  final _api = ApiService();
  List _tareas = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTareas();
  }

  /// Carga las tareas desde el backend y filtra por widget.cursoId
  void _loadTareas() async {
    try {
      final data = await _api.fetchTareas();
      setState(() {
        _tareas = data.where((t) => t['id_curso'] == widget.cursoId).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando tareas';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del curso'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tareas.length,
        itemBuilder: (_, i) {
          final t = _tareas[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(t['nombre_tarea']),
              subtitle:
              Text('Entrega: ${t['fecha_entrega']} - ${t['estado']}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTareaScreen(cursoId: widget.cursoId),
            ),
          ).then((_) {
            // Al volver, recargamos la lista
            _loadTareas();
          });
        },
      ),
    );
  }
}
