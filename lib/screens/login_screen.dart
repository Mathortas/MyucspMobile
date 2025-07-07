// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _api = ApiService();
  bool _loading = false;
  String? _error;

  void _submit() async {
    setState(() { _loading = true; _error = null; });
    final ok = await _api.login(_emailCtl.text, _passCtl.text);
    setState(() => _loading = false);
    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      setState(() => _error = 'Credenciales inválidas');
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 32),
            TextField(
              controller: _emailCtl,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passCtl,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submit,
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
