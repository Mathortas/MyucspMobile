import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _api = ApiService();
  Map<String,dynamic>? _perfil;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _api.fetchMatriculas().then((m) {
      // asumiendo que el perfil está en el token; si lo quieres de /usuarios/, añade un endpoint
      setState(() => _loading = false);
    });
  }

  void _logout() {
    _api.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil del estudiante')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
            SizedBox(height: 16),
            Text('Bienvenido', style: TextStyle(fontSize: 20)),
            Spacer(),
            ElevatedButton(onPressed: _logout, child: Text('Cerrar sesión')),
          ],
        ),
      ),
    );
  }
}
