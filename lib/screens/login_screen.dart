import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailCtl = TextEditingController();
  final passCtl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Logo
            FlutterLogo(size: 120),
            SizedBox(height: 32),

            // Título
            Text('MY UCSP APP',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 48),

            // Email
            TextField(
              controller: emailCtl,
              decoration: InputDecoration(labelText: 'Tu correo'),
            ),

            // Contraseña
            TextField(
              controller: passCtl,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 24),

            // Botón
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 16),

            // Links
            TextButton(
                onPressed: () {},
                child: Text('¿Olvidaste la contraseña?')
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text('Regístrame')
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
