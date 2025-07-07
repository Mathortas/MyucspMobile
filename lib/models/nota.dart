class Nota {
  final int idNota;
  final int idCategoria;
  final int? idTarea;
  final int idMatricula;
  final String nombreNota;
  final double notaObtenida;
  final double pesoPorcentaje;

  Nota({
    required this.idNota,
    required this.idCategoria,
    this.idTarea,
    required this.idMatricula,
    required this.nombreNota,
    required this.notaObtenida,
    required this.pesoPorcentaje,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
    idNota: json['id_nota'],
    idCategoria: json['id_categoria'],
    idTarea: json['id_tarea'],
    idMatricula: json['id_matricula'],
    nombreNota: json['nombre_nota'],
    notaObtenida: double.tryParse(json['nota_obtenida'].toString()) ?? 0.0,
    pesoPorcentaje: double.tryParse(json['peso_porcentaje'].toString()) ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    'id_nota': idNota,
    'id_categoria': idCategoria,
    'id_tarea': idTarea,
    'id_matricula': idMatricula,
    'nombre_nota': nombreNota,
    'nota_obtenida': notaObtenida,
    'peso_porcentaje': pesoPorcentaje,
  };
}