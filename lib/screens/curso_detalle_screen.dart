// lib/screens/curso_detalle_screen.dart
import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../models/curso.dart';
import '../services/api_service.dart';

class CursoDetalleScreen extends StatefulWidget {
  final int cursoId;
  const CursoDetalleScreen({Key? key, required this.cursoId}) : super(key: key);

  @override
  _CursoDetalleScreenState createState() => _CursoDetalleScreenState();
}

class _CursoDetalleScreenState extends State<CursoDetalleScreen> {
  final _api = ApiService();
  List<Tarea> _tareas = [];
  Curso? _curso;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final rawTareas = await _api.fetchTareas();
      final todas = rawTareas.map((j) => Tarea.fromJson(j)).toList();
      final tareasCurso = todas.where((t) => t.idCurso == widget.cursoId).toList();

      final rawCursos = await _api.fetchCursos();
      final cursos = rawCursos.map((j) => Curso.fromJson(j)).toList();
      final curso = cursos.firstWhere(
            (c) => c.idCurso == widget.cursoId,
        orElse: () => Curso(
          idCurso: widget.cursoId,
          nombre: "Desconocido",
          ciclo: "",
          modalidad: "",
          descripcion: "",
          creditos: 0,
        ),
      );

      setState(() {
        _curso = curso;
        _tareas = tareasCurso;
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext c) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle del curso')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle del curso')),
        body: const Center(child: Text('Error cargando datos')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(_curso?.nombre ?? 'Curso')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _curso?.nombre ?? 'Curso desconocido',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(_curso?.descripcion ?? ''),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Tareas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (_tareas.isEmpty)
              const Text('No hay tareas registradas.'),
            ..._tareas.map((t) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(t.nombreTarea),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Entrega: ${t.fechaEntrega.toLocal().toIso8601String().split("T").first}'),
                    Text('Estado: ${t.estado}'),
                    Text('Peso: ${t.pesoPorcentaje}%'),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
