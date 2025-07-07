// lib/models/curso_categoria.dart
import 'categoria_principal.dart';
import 'curso.dart';

class CursoCategoria {
  final int id;
  final double peso;
  final CategoriaPrincipal categoria;
  final Curso curso;

  CursoCategoria({
    required this.id,
    required this.peso,
    required this.categoria,
    required this.curso,
  });

  factory CursoCategoria.fromJson(Map<String, dynamic> json) => CursoCategoria(
    id: json['id'],
    peso: double.tryParse(json['peso'].toString()) ?? 0.0,
    categoria: CategoriaPrincipal.fromJson(json['id_categoria']),
    curso: Curso.fromJson(json['id_curso']),
  );
}
