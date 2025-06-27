import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final userCtl   = TextEditingController();
  final emailCtl  = TextEditingController();
  final passCtl   = TextEditingController();
  final pass2Ctl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userCtl,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: emailCtl,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: passCtl,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            TextField(
              controller: pass2Ctl,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirmar contraseña'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text('Regístrame'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('¿Ya tienes cuenta? Inicia sesión aquí')
            ),
          ],
        ),
      ),
    );
  }
}
