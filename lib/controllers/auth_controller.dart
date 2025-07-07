import '../services/api_service.dart';

class AuthController {
  final ApiService _api = ApiService();

  /// Intenta loguear al usuario. Devuelve `true` si OK, `false` si fallo.
  Future<bool> login(String username, String password) {
    return _api.login(username, password);
  }

  /// Crea un nuevo usuario. Devuelve `true` si OK.
  Future<bool> register(String username, String email, String password1, String password2) {
    // aquí podrías validar que password1 == password2 antes de llamar al servicio
    if (password1 != password2) return Future.value(false);
    return _api.register(username, email, password1);
  }

  /// Elimina los tokens (cierra sesión).
  Future<void> logout() {
    return _api.logout();
  }
}