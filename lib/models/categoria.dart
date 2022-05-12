import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Categoria extends Equatable {
  final String name;
  final Color color;

  Categoria(this.name, this.color);

  @override
  String toString() {
    return 'Categoria{name: $name, color: $color}';
  }

  @override
  List<Object?> get props => [name, color.value];
}