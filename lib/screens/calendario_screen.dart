import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CalendarioScreen extends StatefulWidget {
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  final _api = ApiService();
  List _tareas = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _api.fetchTareas().then((data) {
      setState(() {
        _tareas = data;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendario')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // (aquí seguirías integrando un widget calendario real)
            Text('TAREAS PARA CALENDARIO', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _tareas.length,
                itemBuilder: (_, i) {
                  final t = _tareas[i];
                  return ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text(t['nombre_tarea']),
                    subtitle: Text('Entrega ${t['fecha_entrega']}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
