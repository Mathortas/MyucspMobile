import 'package:flutter/material.dart';
import '../controllers/curso_controller.dart';
import '../models/curso.dart';

class MatriculaScreen extends StatefulWidget {
  const MatriculaScreen({Key? key}) : super(key: key);
  @override
  _MatriculaScreenState createState() => _MatriculaScreenState();
}

class _MatriculaScreenState extends State<MatriculaScreen> {
  final _cursoCtrl = CursoController();
  late Future<List<Curso>> _futAll;

  @override
  void initState() {
    super.initState();
    _futAll = _cursoCtrl.fetchAllCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matricular Cursos')),
      body: FutureBuilder<List<Curso>>(
        future: _futAll,
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final cursos = snap.data!;
          return ListView.builder(
            itemCount: cursos.length,
            itemBuilder: (_, i) {
              final c = cursos[i];
              return Card(
                child: ListTile(
                  title: Text(c.nombre),
                  trailing: ElevatedButton(
                    child: const Text('Matricular'),
                    onPressed: () async {
                      await _cursoCtrl.createMatricula(c.idCurso, c.ciclo);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
