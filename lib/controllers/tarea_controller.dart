import '../models/tarea.dart';
import '../services/api_service.dart';

class TareaController {
  final ApiService _api = ApiService();

  /// Trae todas las tareas del usuario
  Future<List<Tarea>> fetchAllTareas() async {
    final raw = await _api.fetchTareas();
    return raw.map<Tarea>((j) => Tarea.fromJson(j)).toList();
  }

  /// Trae las tareas filtradas por curso
  Future<List<Tarea>> fetchTareasByCurso(int cursoId) async {
    final todas = await fetchAllTareas();
    return todas.where((t) => t.idCurso == cursoId).toList();
  }

  /// Crea una nueva tarea / prueba
  Future<bool> createTarea({
    required String nombre,
    required String fechaEntrega,
    required String estado,
    required String categoria,
    required double pesoPorcentaje,
    required int cursoId,
  }) {
    return _api.createTarea(
      nombre: nombre,
      fechaEntrega: fechaEntrega,
      estado: estado,
      categoria: categoria,
      pesoPorcentaje: pesoPorcentaje,
      cursoId: cursoId,
    );
  }

  /// Actualiza campos de la tarea
  Future<bool> updateTarea(int tareaId, Map<String, dynamic> cambios) {
    return _api.updateTarea(tareaId, cambios);
  }
}