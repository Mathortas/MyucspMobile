import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Iniciar Sesión", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Ingresar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text("¿No tienes cuenta? Regístrate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
