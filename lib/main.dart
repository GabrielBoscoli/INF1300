import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ListaGastos()
    );
  }
}

class FormularioGasto extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioGastoState();
  }

}

class FormularioGastoState extends State<FormularioGasto> {

  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Gasto'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                _controladorCampoNumeroConta,
                'Número da conta',
                '0000',
              ),
              Editor(
                _controladorCampoValor,
                'Valor',
                '0.00',
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text('Confirmar'),
                onPressed: () => _criaGasto(context),
              )
            ],
          ),
        ));
  }

  void _criaGasto(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final Gasto gastoCriado = Gasto(valor, numeroConta, Categorias.GASOLINA);
      debugPrint('Criando gasto');
      debugPrint('$gastoCriado');
      Navigator.pop(context, gastoCriado);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor(this.controlador, this.rotulo, this.dica, {this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

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

class ItemGasto extends StatelessWidget {
  final Gasto _gasto;

  ItemGasto(this._gasto);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_down_rounded,
                size: 32,
                color: Colors.red,
              ),
              Icon(
                Icons.monetization_on_rounded,
                size: 32,
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ],
      ),
      title: Column(
        children: [
          getCategoria(_gasto.categoria.index),
          Text(_gasto.valor.toString()),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      subtitle: Text(_gasto.numeroConta.toString()),
    ));
  }
}

class Gasto {
  final double valor;
  final int numeroConta;
  final Categorias categoria;

  Gasto(this.valor, this.numeroConta, this.categoria);

  @override
  String toString() {
    return 'Gasto{valor: $valor, numeroConta: $numeroConta, categoria: $categoria}';
  }
}

enum Categorias { BEBIDA, GASOLINA, COMIDA, FESTA }

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
