// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _api = ApiService();
  bool _loading = true;
  String? _error;
  Map<String, dynamic>? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await _api.fetchProfile();
      setState(() {
        _profile = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext _) {
    if (_loading) return Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Text(_error!)));

    return Scaffold(
      appBar: AppBar(title: Text('Mi Perfil')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuario: ${_profile!['username']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nombre: ${_profile!['first_name']} ${_profile!['last_name']}'),
            SizedBox(height: 8),
            Text('Correo: ${_profile!['email']}'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _api.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
