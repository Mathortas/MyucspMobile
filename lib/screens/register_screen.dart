import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Registro", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(height: 24),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Nombre de usuario'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              TextField(
                controller: password2Controller,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Repetir contraseña'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
