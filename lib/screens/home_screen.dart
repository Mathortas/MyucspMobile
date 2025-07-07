// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/matricula.dart';
import '../models/curso.dart';
import '../services/api_service.dart';
import 'curso_detalle_screen.dart';
import 'profile_screen.dart';
import 'calendario_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  List<Matricula> _matriculas = [];
  Map<int, Curso> _cursos = {};
  bool _loading = true, _error = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final rawMatriculas = await _api.fetchMatriculas();
      final rawCursos = await _api.fetchCursos();
      setState(() {
        _matriculas = rawMatriculas.map((j) => Matricula.fromJson(j)).toList();
        _cursos = {
          for (var c in rawCursos.map((j) => Curso.fromJson(j)))
            c.idCurso: c
        };
        _loading = false;
      });
    } catch (_) {
      setState(() { _error = true; _loading = false; });
    }
  }

  Future<void> _logout() async {
    await _api.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
          (_) => false,
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CalendarioScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error
          ? const Center(child: Text('Error cargando cursos'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _matriculas.length,
        itemBuilder: (_, i) {
          final m = _matriculas[i];
          final curso = _cursos[m.idCurso];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                curso?.nombre ?? 'Curso desconocido',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Ciclo: ${m.ciclo}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
            ),
          );
        },
      ),
    );
  }
}
