import 'package:bytebank/components/loading.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class ListaGastos extends StatefulWidget {
  final GastoDao _gastoDao = const GastoDao();

  ListaGastos({Key? key}) : super(key: key);

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
    super.initState();
    _futureGastos = widget._gastoDao.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dataanalysis');
            },
            icon: const Icon(Icons.analytics_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<Gasto>>(
          future: _futureGastos,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _listBuilder();
              case ConnectionState.waiting:
                return Loading();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Gasto>? gastos = snapshot.data;
                if (gastos != null) {
                  _gastos = gastos;
                } else {
                  _gastos = [];
                }
                _futureGastos = null;
                return _listBuilder();
            }
            return const Text('Unknown error');
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final Future future =
              Navigator.pushNamed(context, '/novogasto');
          future.then((gastoRecebido) {
            if (gastoRecebido != null) {
              setState(() {
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
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 8), // padding para nao bloquear a edicao do ultimo item
      itemCount: _gastos.length,
      itemBuilder: (context, indice) {
        final gasto = _gastos[indice];
        return ItemGasto(
          gasto,
          deleteCallback: deleteGasto,
          editCallback: editGasto,
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

  editGasto(Gasto gasto) {
    int index = _gastos.indexOf(gasto);
    if (index != -1) {
      setState(() {
        _gastos[index] = gasto;
      });
    }
  }
}
