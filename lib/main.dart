import 'package:bytebank/screens/gasto/lista.dart';
import 'package:bytebank/screens/gasto/nova_categoria.dart';
import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ListaGastos(),
    );
  }
}

final List<Chip> categoriaChips = [
  Chip(
    label: const Text('Bebida'),
    backgroundColor: Colors.blue,
  ),
  Chip(
    label: const Text('Gasolina'),
    backgroundColor: Colors.deepOrange,
  ),
  Chip(
    label: const Text('Comida'),
    backgroundColor: Colors.green,
  ),
  Chip(
    label: const Text('Festa'),
    backgroundColor: Colors.pink,
  )
];

Chip getCategoria(int i) {
  return categoriaChips[i];
}
