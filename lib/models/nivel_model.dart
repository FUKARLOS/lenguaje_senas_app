class Nivel {
  final int id;
  final String nombre;
  final String description;

  Nivel({required this.id, required this.nombre, required this.description});

  factory Nivel.fromMap(Map<String, dynamic> map) {
    return Nivel(
      id: map['id'] as int,
      nombre: map['nombre'] ?? '',
      description:
          map['descripcion'] ??
          '', // Note: 'descripcion' in DB, 'description' in model
    );
  }
}
