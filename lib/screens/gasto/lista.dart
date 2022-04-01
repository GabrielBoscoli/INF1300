import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';

import 'novo_gasto.dart';
import 'item.dart';

class ListaGastos extends StatefulWidget {
  final List<Gasto> gastos = [];

  @override
  State<StatefulWidget> createState() {
    return ListaGastosState();
  }

}

class ListaGastosState extends State<ListaGastos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos'),
      ),
      body: ListView.builder(
        itemCount: widget.gastos.length,
        itemBuilder: (context, indice) {
          final gasto = widget.gastos[indice];
          return ItemGasto(gasto);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Gasto?> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioGasto();
          }));
          future.then((gastoRecebido) {
            debugPrint('chegou no then do future');
            debugPrint('$gastoRecebido');
            if (gastoRecebido != null) {
              setState(() {
                widget.gastos.add(gastoRecebido);
              });
            }
          });
        },
      ),
    );
  }
}