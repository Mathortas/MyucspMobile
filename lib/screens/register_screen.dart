import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authCtrl = AuthController();
  final _userCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _pass1Ctl = TextEditingController();
  final _pass2Ctl = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() { _loading = true; _error = null; });
    final ok = await _authCtrl.register(
      _userCtl.text,
      _emailCtl.text,
      _pass1Ctl.text,
      _pass2Ctl.text,
    );
    setState(() => _loading = false);
    if (ok) {
      Navigator.pop(context); // vuelve al login
    } else {
      setState(() => _error = 'Error en registro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            TextField(
              controller: _userCtl,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _emailCtl,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: _pass1Ctl,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _pass2Ctl,
              decoration: const InputDecoration(labelText: 'Repetir Contraseña'),
              obscureText: true,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 24),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _submit,
              child: const Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
