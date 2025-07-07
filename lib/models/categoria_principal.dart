// lib/models/categoria_principal.dart
class CategoriaPrincipal {
  final int idCategoria;
  final String nombre;
  final double pesoPorcentaje;
  final String tipo; // 'PRINCIPAL' o 'SECUNDARIA'

  CategoriaPrincipal({
    required this.idCategoria,
    required this.nombre,
    required this.pesoPorcentaje,
    required this.tipo,
  });

  factory CategoriaPrincipal.fromJson(Map<String, dynamic> json) => CategoriaPrincipal(
    idCategoria: json['id_categoria'],
    nombre: json['nombre'],
    pesoPorcentaje: (json['peso_porcentaje'] as num).toDouble(),
    tipo: json['tipo'],
  );
}
