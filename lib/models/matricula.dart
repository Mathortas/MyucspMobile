// lib/models/matricula.dart
import 'curso.dart';

class Matricula {
  final int idMatricula;
  final int idCurso;
  final String ciclo;
  final String fechaMatricula;

  Matricula({
    required this.idMatricula,
    required this.idCurso,
    required this.ciclo,
    required this.fechaMatricula,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) {
    return Matricula(
      idMatricula: json['id_matricula'],
      idCurso: json['id_curso'],
      ciclo: json['ciclo'],
      fechaMatricula: json['fecha_matricula'],
    );
  }
}

