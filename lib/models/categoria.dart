import 'package:flutter/material.dart';

// enum Categorias { BEBIDA, GASOLINA, COMIDA, FESTA }

class Categoria {
  final String name;
  final Color color;

  Categoria(this.name, this.color);

  @override
  String toString() {
    return 'Categoria{name: $name, color: $color}';
  }
}