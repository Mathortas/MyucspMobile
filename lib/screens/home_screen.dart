import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'curso_detalle_screen.dart';
import 'calendario_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  List _cursos = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCursos();
  }

  void _loadCursos() async {
    try {
      final data = await _api.fetchCursos();
      setState(() {
        _cursos = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error cargando cursos';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis cursos'),
        actions: [
          IconButton(icon: Icon(Icons.calendar_today),
              onPressed: () => Navigator.push(
                  c, MaterialPageRoute(builder: (_) => CalendarioScreen()))),
          IconButton(icon: Icon(Icons.person),
              onPressed: () => Navigator.push(
                  c, MaterialPageRoute(builder: (_) => ProfileScreen()))),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: _cursos.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemBuilder: (_, i) {
          if (i == 0) {
            return GestureDetector(
              onTap: () {}, // luego
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
                child: Center(child: Icon(Icons.add, size: 48, color: Colors.grey)),
              ),
            );
          }
          final curso = _cursos[i - 1];
          return GestureDetector(
            onTap: () => Navigator.push(
                c,
                MaterialPageRoute(
                    builder: (_) => CursoDetalleScreen(cursoId: curso['id_curso']))),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.primaries[i % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(curso['nombre'],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
