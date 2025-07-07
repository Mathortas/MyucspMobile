// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

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
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuario: ${_profile!['username']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Correo: ${_profile!['email']}'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _api.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                        (_) => false,
                  );
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
