// lib/screens/add_tarea_screen.dart
import 'package:flutter/material.dart';
import '../models/categoria_principal.dart';
import '../services/api_service.dart';

class AddTareaScreen extends StatefulWidget {
  final int cursoId;
  const AddTareaScreen({Key? key, required this.cursoId}) : super(key: key);

  @override
  _AddTareaScreenState createState() => _AddTareaScreenState();
}

class _AddTareaScreenState extends State<AddTareaScreen> {
  final _nombreCtl = TextEditingController();
  final _descCtl   = TextEditingController();
  final _dateCtl   = TextEditingController();
  final _pesoCtl   = TextEditingController();
  String _tipo   = 'TAREA';
  CategoriaPrincipal? _categoria;
  List<CategoriaPrincipal> _cats = [];
  bool _loadingCats = true;

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  Future<void> _loadCategorias() async {
    // Si tu API expone /categorias/
    // Después parsea con CategoriaPrincipal.fromJson
    // Para simplificar aquí hardcodeamos:
    setState(() {
      _cats = [
        CategoriaPrincipal(idCategoria:1, nombre:'Parcial', pesoPorcentaje:30, tipo:'PRINCIPAL'),
        CategoriaPrincipal(idCategoria:2, nombre:'Tarea', pesoPorcentaje:10, tipo:'SECUNDARIA'),
      ];
      _categoria = _cats.first;
      _loadingCats = false;
    });
  }

  void _save() async {
    final ok = await ApiService().createTarea(
      nombre: _nombreCtl.text,
      fechaEntrega: _dateCtl.text,
      estado: 'PENDIENTE',
      categoria: _categoria!.idCategoria.toString(),
      pesoPorcentaje: double.parse(_pesoCtl.text),
      cursoId: widget.cursoId,
    );
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext c) {
    if (_loadingCats) return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Tarea o Prueba")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _nombreCtl, decoration: InputDecoration(labelText:'Nombre')),
            TextField(controller: _descCtl,   decoration: InputDecoration(labelText:'Descripción')),
            TextField(controller: _dateCtl,   decoration: InputDecoration(labelText:'Fecha (YYYY-MM-DD)')),
            TextField(controller: _pesoCtl,   decoration: InputDecoration(labelText:'Peso (%)'), keyboardType: TextInputType.number),
            DropdownButtonFormField<String>(
              value: _tipo,
              decoration: InputDecoration(labelText: 'Tipo'),
              items: ['TAREA','PRACTICA_GRUPAL','CONTROL'].map((v) =>
                  DropdownMenuItem(value:v, child: Text(v)),
              ).toList(),
              onChanged: (v)=>setState(()=>_tipo=v!),
            ),
            DropdownButtonFormField<CategoriaPrincipal>(
              value: _categoria,
              decoration: InputDecoration(labelText: 'Categoría'),
              items: _cats.map((c)=> DropdownMenuItem(value:c, child: Text(c.nombre))).toList(),
              onChanged: (c)=>setState(()=>_categoria=c!),
            ),
            SizedBox(height:20),
            ElevatedButton(onPressed:_save, child: Text("Guardar")),
          ],
        ),
      ),
    );
  }
}
