class Horario {
  final int idHorario;
  final int idCurso;
  final String diaSemana;
  final String horaInicio; // podrías usar TimeOfDay en UI
  final String horaFin;
  final String? aula;

  Horario({
    required this.idHorario,
    required this.idCurso,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
    this.aula,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
    idHorario: json['id_horario'],
    idCurso: json['id_curso'],
    diaSemana: json['dia_semana'],
    horaInicio: json['hora_inicio'],
    horaFin: json['hora_fin'],
    aula: json['aula'],
  );

  Map<String, dynamic> toJson() => {
    'id_horario': idHorario,
    'id_curso': idCurso,
    'dia_semana': diaSemana,
    'hora_inicio': horaInicio,
    'hora_fin': horaFin,
    'aula': aula,
  };
}