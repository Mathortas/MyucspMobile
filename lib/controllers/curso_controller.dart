import '../models/curso.dart';
import '../models/matricula.dart';
import '../services/api_service.dart';

class CursoController {
  final ApiService _api = ApiService();

  /// Trae todos los cursos disponibles
  Future<List<Curso>> fetchAllCursos() async {
    final raw = await _api.fetchCursos();
    return raw.map<Curso>((j) => Curso.fromJson(j)).toList();
  }

  /// Trae las matrículas del usuario logueado
  Future<List<Matricula>> fetchMyMatriculas() async {
    final raw = await _api.fetchMatriculas();
    return raw.map<Matricula>((j) => Matricula.fromJson(j)).toList();
  }

  /// Matricula al usuario en un curso dado
  Future<bool> createMatricula(int cursoId, String ciclo) {
    return _api.createMatricula(cursoId, ciclo);
  }
}