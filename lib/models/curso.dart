class Curso {
  final int idCurso;
  final String nombre;
  final String ciclo;
  final String modalidad;
  final String descripcion;
  final int creditos;

  Curso({
    required this.idCurso,
    required this.nombre,
    required this.ciclo,
    required this.modalidad,
    required this.descripcion,
    required this.creditos,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
    idCurso: json['id_curso'],
    nombre: json['nombre'] ?? '',
    ciclo: json['ciclo'] ?? '',
    modalidad: json['modalidad'] ?? '',
    descripcion: json['descripcion'] ?? '',
    creditos: json['creditos'] ?? 0,
  );
}
