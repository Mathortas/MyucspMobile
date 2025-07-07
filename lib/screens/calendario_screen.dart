// lib/screens/calendario_screen.dart
import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../services/api_service.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({Key? key}): super(key:key);
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  final _api = ApiService();
  List<Tarea> _pendientes = [];
  bool _loading=true, _error=false;

  @override
  void initState(){
    super.initState();
    _loadPendientes();
  }

  Future<void> _loadPendientes() async {
    try {
      final raw = await _api.fetchTareas();
      setState(() {
        _pendientes = raw
            .map((j)=>Tarea.fromJson(j))
            .where((t)=>t.estado=='PENDIENTE')
            .toList();
        _loading=false;
      });
    } catch(_) {
      setState(() { _error=true; _loading=false; });
    }
  }

  @override
  Widget build(BuildContext ctx){
    if (_loading) return Center(child: CircularProgressIndicator());
    if (_error)   return Center(child: Text('Error cargando calendario'));
    return ListView.builder(
        itemCount: _pendientes.length,
        itemBuilder: (_,i){
          final t = _pendientes[i];
          return ListTile(
            leading: Icon(Icons.pending_actions),
            title: Text(t.nombreTarea),
            subtitle: Text('Entrega: ${t.fechaEntrega.toLocal().toIso8601String().split("T").first}'),
          );
        }
    );
  }
}
