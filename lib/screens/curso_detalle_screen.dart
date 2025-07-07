// lib/screens/curso_detalle_screen.dart
import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../models/curso.dart';
import '../services/api_service.dart';
import 'add_tarea_screen.dart';

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
      // Traer todas las tareas
      final rawTareas = await _api.fetchTareas();
      final todas = rawTareas.map((j) => Tarea.fromJson(j)).toList();
      final tareasCurso = todas.where((t) => t.idCurso == widget.cursoId).toList();

      // Traer todos los cursos y obtener el curso actual
      final rawCursos = await _api.fetchCursos();
      final cursos = rawCursos.map((j) => Curso.fromJson(j)).toList();
      final curso = cursos.firstWhere((c) => c.idCurso == widget.cursoId, orElse: () => Curso(
          idCurso: widget.cursoId,
          nombre: "Desconocido",
          ciclo: "",
          modalidad: "",
          descripcion: "",
          creditos: 0
      ));

      setState(() {
        _curso = curso;
        _tareas = tareasCurso;
        _loading = false;
        _error = false;
      });
    } catch (e) {
      print("ERROR LOAD DATA: $e");
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del curso')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error
          ? Center(child: Text('Error cargando datos'))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del curso
            Text(
              _curso?.nombre ?? 'Curso Desconocido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(_curso?.descripcion ?? ''),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Tareas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            if (_tareas.isEmpty)
              Text('No hay tareas registradas.'),
            ..._tareas.map((t) => Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(t.nombreTarea),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Entrega: ${t.fechaEntrega.toLocal().toIso8601String().split("T").first}'),
                    Text('Estado: ${t.estado}'),
                    Text('Peso: ${t.pesoPorcentaje}%'),
                    Text('Categoría ID: ${t.idCategoria}'),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(
            builder: (_) => AddTareaScreen(cursoId: widget.cursoId),
          ),
        ).then((_) => _loadData()),
        child: Icon(Icons.add),
      ),
    );
  }
}
