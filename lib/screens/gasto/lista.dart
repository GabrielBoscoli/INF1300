import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';

import 'novo_gasto.dart';
import 'item.dart';

class ListaGastos extends StatefulWidget {
  final GastoDao _gastoDao = const GastoDao();

  const ListaGastos({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaGastosState();
  }
}

class ListaGastosState extends State<ListaGastos> {
  late Future<List<Gasto>>? _futureGastos;
  late final List<Gasto> _gastos;

  @override
  void initState() {
    debugPrint('lista init state...');
    super.initState();
    _futureGastos = widget._gastoDao.findAll();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building lista...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
      ),
      body: FutureBuilder<List<Gasto>>(
          future: _futureGastos,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                debugPrint('connection state none');
                return _listBuilder();
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      Text('Loading')
                    ],
                  ),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                debugPrint('connection state done');
                final List<Gasto>? gastos = snapshot.data;
                if (gastos != null) {
                  _gastos = gastos;
                } else {
                  _gastos = [];
                }
                // vai fazer com que no proximo build o connection state seja none.
                _futureGastos = null;
                return _listBuilder();
            }
            return const Text('Unknown error');
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
                debugPrint('adicionou o gasto');
                _gastos.add(gastoRecebido);
              });
            }
          });
        },
      ),
    );
  }

  ListView _listBuilder() {
    return ListView.builder(
      itemCount: _gastos.length,
      itemBuilder: (context, indice) {
        final gasto = _gastos[indice];
        return ItemGasto(
          gasto,
          deleteCallback: deleteGasto,
        );
      },
    );
  }

  deleteGasto(Gasto gasto) {
    bool resp = false;
    setState(() {
      resp = _gastos.remove(gasto);
    });
    if (resp) {
      debugPrint('gasto removido');
    } else {
      debugPrint('gasto não removido');
    }
  }
}
