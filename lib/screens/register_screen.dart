import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userCtl  = TextEditingController();
  final _emailCtl = TextEditingController();
  final _pass1Ctl = TextEditingController();
  final _pass2Ctl = TextEditingController();
  final _api      = ApiService();
  bool _loading   = false;
  String? _error;

  void _submit() async {
    if (_pass1Ctl.text != _pass2Ctl.text) {
      setState(() => _error = 'Las contraseñas no coinciden');
      return;
    }
    setState(() { _loading = true; _error = null; });
    final ok = await _api.register(_userCtl.text, _emailCtl.text, _pass1Ctl.text);
    setState(() => _loading = false);
    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      setState(() => _error = 'Error al registrar');
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _userCtl, decoration: InputDecoration(labelText: 'Usuario')),
            TextField(controller: _emailCtl, decoration: InputDecoration(labelText: 'Correo')),
            TextField(controller: _pass1Ctl, decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            TextField(controller: _pass2Ctl, decoration: InputDecoration(labelText: 'Confirmar contraseña'), obscureText: true),
            if (_error != null) ...[
              SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 24),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: _submit, child: Text('Regístrame')),
            TextButton(onPressed: () => Navigator.pop(context), child: Text('¿Ya tienes cuenta?')),
          ],
        ),
      ),
    );
  }
}
