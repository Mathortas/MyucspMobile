// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // Cambia esta URL por la de tu servidor Django
  static const _baseUrl = 'https://myucsp.onrender.com/api';

  // Para almacenar el token JWT de forma segura
  final _storage = FlutterSecureStorage();

  /// 1) Autenticación: LOGIN
  /// Devuelve true si logra loguearse y guarda el access token.
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('https://myucsp.onrender.com/api/token/');
    print("Enviando POST a $url con usuario=$username y pass=$password");
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    print("STATUS: ${resp.statusCode}");
    print("BODY: ${resp.body}");

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      await _storage.write(key: 'access', value: data['access']);
      await _storage.write(key: 'refresh', value: data['refresh']);
      return true;
    }
    return false;
  }


  /// 2) Registrar nuevo usuario
  Future<bool> register(String username, String email, String password) async {
    final resp = await http.post(
      Uri.parse('$_baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    return resp.statusCode == 201;
  }

  /// Utilidad para obtener los headers con token
  Future<Map<String, String>> _authHeaders() async {
    final token = await _storage.read(key: 'access');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// 3) Traer todos los cursos
  Future<List<dynamic>> fetchCursos() async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$_baseUrl/cursos/'), headers: headers);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    }
    throw Exception('Error cargando cursos');
  }

  /// 4) Traer matrículas del usuario
  Future<List<dynamic>> fetchMatriculas() async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$_baseUrl/matriculas/'), headers: headers);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    }
    throw Exception('Error cargando matriculas');
  }

  /// 5) Crear una matrícula nueva
  Future<bool> createMatricula(int cursoId, String ciclo) async {
    final headers = await _authHeaders();
    final resp = await http.post(
      Uri.parse('$_baseUrl/matriculas/'),
      headers: headers,
      body: json.encode({
        'id_curso': cursoId,
        'ciclo': ciclo,
        'fecha_matricula': DateTime.now().toIso8601String().split('T').first,
      }),
    );
    return resp.statusCode == 201;
  }

  /// 6) Traer tareas del usuario
  Future<List<dynamic>> fetchTareas() async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$_baseUrl/tareas/'), headers: headers);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    }
    throw Exception('Error cargando tareas');
  }

  /// 7) Crear una tarea/prueba nueva
  Future<bool> createTarea({
    required String nombre,
    required String fechaEntrega, // formato 'YYYY-MM-DD'
    required String estado,
    required String categoria,
    required double pesoPorcentaje,
    required int cursoId,
  }) async {
    final headers = await _authHeaders();
    final resp = await http.post(
      Uri.parse('$_baseUrl/tareas/'),
      headers: headers,
      body: json.encode({
        'nombre_tarea': nombre,
        'fecha_entrega': fechaEntrega,
        'estado': estado,
        'categoria': categoria,
        'peso_porcentaje': pesoPorcentaje,
        'id_curso': cursoId,
      }),
    );
    return resp.statusCode == 201;
  }

  /// 8) Actualizar estado o datos de una tarea
  Future<bool> updateTarea(int tareaId, Map<String, dynamic> cambios) async {
    final headers = await _authHeaders();
    final resp = await http.patch(
      Uri.parse('$_baseUrl/tareas/$tareaId/'),
      headers: headers,
      body: json.encode(cambios),
    );
    return resp.statusCode == 200;
  }

  /// 9) Traer notas del usuario
  Future<List<dynamic>> fetchNotas() async {
    final headers = await _authHeaders();
    final resp = await http.get(Uri.parse('$_baseUrl/notas/'), headers: headers);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    }
    throw Exception('Error cargando notas');
  }

  /// 🔟 Crear una nota asociada a una tarea/matrícula
  Future<bool> createNota({
    required String nombreNota,
    required double notaObtenida,
    required double pesoPorcentaje,
    required String permanentePromedio,
    required int matriculaId,
  }) async {
    final headers = await _authHeaders();
    final resp = await http.post(
      Uri.parse('$_baseUrl/notas/'),
      headers: headers,
      body: json.encode({
        'nombre_nota': nombreNota,
        'nota_obtenida': notaObtenida,
        'peso_porcentaje': pesoPorcentaje,
        'permanente_promedio': permanentePromedio,
        'id_matricula': matriculaId,
      }),
    );
    return resp.statusCode == 201;
  }

  /// 1️⃣1️⃣ Refrescar token JWT
  Future<bool> refreshToken() async {
    final refresh = await _storage.read(key: 'refresh');
    if (refresh == null) return false;
    final resp = await http.post(
      Uri.parse('$_baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refresh': refresh}),
    );
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      await _storage.write(key: 'access', value: data['access']);
      return true;
    }
    return false;
  }

  /// Cerrar sesión: borrar tokens
  Future<void> logout() async {
    await _storage.delete(key: 'access');
    await _storage.delete(key: 'refresh');
  }
}

