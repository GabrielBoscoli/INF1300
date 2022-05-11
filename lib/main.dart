import 'package:bytebank/screens/analysis/data_analysis.dart';
import 'package:bytebank/screens/gasto/categoria/nova_categoria.dart';
import 'package:bytebank/screens/gasto/lista.dart';
import 'package:bytebank/screens/gasto/novo_gasto.dart';
import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ListaGastos(),
      routes: <String, WidgetBuilder>{
        '/novogasto': (BuildContext context) => NovoGasto(),
        '/dataanalysis': (BuildContext context) => DataAnalysis(),
        '/novacategoria': (BuildContext context) => NovaCategoria(),
      },
    );
  }
}
