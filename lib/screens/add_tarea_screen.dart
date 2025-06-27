import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddTareaScreen extends StatefulWidget {
  final int cursoId;

  // Constructor que recibe el cursoId
  const AddTareaScreen({
    Key? key,
    required this.cursoId,
  }) : super(key: key);

  @override
  _AddTareaScreenState createState() => _AddTareaScreenState();
}

class _AddTareaScreenState extends State<AddTareaScreen> {
  final _api                 = ApiService();
  final _nombreController    = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fechaController     = TextEditingController();
  String _categoria          = 'P1';
  bool _loading              = false;
  String? _error;

  void _submit() async {
    final nombre    = _nombreController.text.trim();
    final descripcion = _descripcionController.text.trim();
    final fecha     = _fechaController.text.trim(); // espera 'YYYY-MM-DD'
    if (nombre.isEmpty || fecha.isEmpty) {
      setState(() => _error = 'Nombre y fecha son obligatorios');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    final ok = await _api.createTarea(
      nombre: nombre,
      fechaEntrega: fecha,
      estado: 'pendiente',
      categoria: _categoria,
      pesoPorcentaje: 0.0,
      cursoId: widget.cursoId,
    );

    setState(() => _loading = false);

    if (ok) {
      Navigator.pop(context);
    } else {
      setState(() => _error = 'Error al crear la tarea');
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Tarea o Prueba")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (_error != null) ...[
              Text(_error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 12),
            ],
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha de entrega',
                hintText: 'YYYY-MM-DD',
              ),
            ),
            DropdownButtonFormField<String>(
              value: _categoria,
              decoration: InputDecoration(labelText: "Categoría"),
              items: [
                DropdownMenuItem(value: 'P1', child: Text("Permanente 1")),
                DropdownMenuItem(value: 'P2', child: Text("Permanente 2")),
                DropdownMenuItem(value: 'PAR', child: Text("Parcial")),
                DropdownMenuItem(value: 'FIN', child: Text("Final")),
              ],
              onChanged: (v) => setState(() => _categoria = v!),
            ),
            SizedBox(height: 20),
            _loading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _submit,
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}