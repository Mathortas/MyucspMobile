import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../models/matricula.dart';
import '../services/api_service.dart';
import 'curso_detalle_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  List<Matricula> _matriculas = [];
  Map<int, Curso> _cursos = {};
  bool _loading = true,
      _error = false;

  @override
  void initState() {
    super.initState();
    _loadMatriculas();
  }

  Future<void> _loadMatriculas() async {
    try {
      final rawMatriculas = await _api.fetchMatriculas();
      final matriculas = rawMatriculas
          .map((j) => Matricula.fromJson(j))
          .toList();

      final rawCursos = await _api.fetchCursos();
      final cursosList = rawCursos.map((j) => Curso.fromJson(j)).toList();
      final cursosMap = { for (var c in cursosList) c.idCurso: c};

      setState(() {
        _matriculas = matriculas;
        _cursos = cursosMap;
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
  Widget build(BuildContext ctx) {
    if (_loading) return Center(child: CircularProgressIndicator());
    if (_error) return Center(child: Text('Error cargando cursos'));

    return Scaffold(
      appBar: AppBar(title: Text('Mis cursos')),
      body: ListView.builder(
        itemCount: _matriculas.length,
        itemBuilder: (_, i) {
          final m = _matriculas[i];
          final curso = _cursos[m.idCurso];

          return ListTile(
            title: Text(curso != null ? curso.nombre : 'Curso Desconocido'),
            subtitle: Text('Ciclo: ${m.ciclo}'),
            onTap: () {
              if (curso != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CursoDetalleScreen(cursoId: curso.idCurso),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
