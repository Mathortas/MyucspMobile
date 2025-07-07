// lib/screens/calendario_screen.dart
import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../services/api_service.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({Key? key}) : super(key: key);
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  final _api = ApiService();
  List<Tarea> _pendientes = [];
  bool _loading = true, _error = false;

  @override
  void initState() {
    super.initState();
    _loadPendientes();
  }

  Future<void> _loadPendientes() async {
    try {
      final raw = await _api.fetchTareas();
      setState(() {
        _pendientes = raw
            .map((j) => Tarea.fromJson(j))
            .where((t) => t.estado == 'PENDIENTE')
            .toList();
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _error = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Calendario')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error) {
      return Scaffold(
        appBar: AppBar(title: const Text('Calendario')),
        body: const Center(child: Text('Error cargando calendario')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _pendientes.length,
        itemBuilder: (_, i) {
          final t = _pendientes[i];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.pending_actions, color: Colors.blue),
              title: Text(
                t.nombreTarea,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Entrega: ${t.fechaEntrega.toLocal().toIso8601String().split("T").first}',
              ),
            ),
          );
        },
      ),
    );
  }
}
