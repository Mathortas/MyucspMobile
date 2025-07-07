class Tarea {
  final int idTarea;
  final int idCurso;
  final int idCategoria;
  final String nombreTarea;
  final String descripcion;
  final DateTime fechaEntrega;
  final String estado;
  final String tipo;
  final double pesoPorcentaje;

  Tarea({
    required this.idTarea,
    required this.idCurso,
    required this.idCategoria,
    required this.nombreTarea,
    required this.descripcion,
    required this.fechaEntrega,
    required this.estado,
    required this.tipo,
    required this.pesoPorcentaje,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
    idTarea: json['id_tarea'] as int,
    idCurso: json['id_curso'] as int,
    idCategoria: json['id_categoria'] as int,
    nombreTarea: json['nombre_tarea'] ?? '',
    descripcion: json['descripcion'] ?? '',
    fechaEntrega: DateTime.parse(json['fecha_entrega']),
    estado: json['estado'] ?? '',
    tipo: json['tipo'] ?? '',
    pesoPorcentaje: double.tryParse(json['peso_porcentaje'].toString()) ?? 0.0,
  );

}
