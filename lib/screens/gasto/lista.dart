import 'package:bytebank/components/geral/loading.dart';
import 'package:bytebank/components/meta/meta_appbar_text.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/meta_store.dart';
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
  late MetaStore metaStore;

  @override
  void initState() {
    super.initState();
    _futureGastos = widget._gastoDao.findAll();
  }

  @override
  Widget build(BuildContext context) {
    metaStore = Provider.of<MetaStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
        actions: <Widget>[
          MetaAppBarText(),
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
    setState(() {
      _gastos.remove(gasto);
    });
    metaStore.subAtual(gasto.data, gasto.valor.toInt());
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
