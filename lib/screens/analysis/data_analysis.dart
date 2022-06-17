import 'dart:async';

import 'package:bytebank/components/geral/default_container.dart';
import 'package:bytebank/screens/analysis/item.dart';
import 'package:bytebank/screens/analysis/moedas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/geral/editor.dart';
import '../../components/geral/loading.dart';
import '../../components/meta/meta_appbar_text.dart';
import '../../database/dao/gasto_dao.dart';
import '../../models/categoria.dart';

class DataAnalysis extends StatefulWidget {
  static const String _appBarTitle = 'Analise de dados';
  static const String _dataInicialLabel = 'Data inicial';
  static const String _dataFinalLabel = 'Data final';
  static const GastoDao _gastoDao = GastoDao();

  DataAnalysis({Key? key}) : super(key: key);

  @override
  State<DataAnalysis> createState() => _DataAnalysisState();
}

class _DataAnalysisState extends State<DataAnalysis> {
  final _dataCorrente = DateTime.now();

  late DateTime _dataInicial =
      DateTime(_dataCorrente.year, _dataCorrente.month, 1);

  late DateTime _dataFinal = DateTime.now();

  final DateFormat _formatter = DateFormat('dd-MM-yyyy');

  late final _controladorCampoDataInicial =
      TextEditingController(text: _formatter.format(_dataInicial));

  late final _controladorCampoDataFinal =
      TextEditingController(text: _formatter.format(_dataFinal));

  final StreamController<Map<Categoria, double>> _streamController =
      StreamController<Map<Categoria, double>>();

  Map<Categoria, double> _mapCategoriaValor = {};

  double _valorTotal = 0;

  @override
  void initState() {
    super.initState();
    loadLista();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  loadLista() async {
    _valorTotal = await DataAnalysis._gastoDao
        .findTotalByDate(DateTimeRange(start: _dataInicial, end: _dataFinal));
    Map<Categoria, double> dado = await DataAnalysis._gastoDao
        .findByDateGroupedByCategoria(
            DateTimeRange(start: _dataInicial, end: _dataFinal));
    _streamController.add(dado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DataAnalysis._appBarTitle),
        actions: <Widget>[
          MetaAppBarText(),
        ],
      ),
      body: Column(
        children: [
          Editor(
            _controladorCampoDataInicial,
            DataAnalysis._dataInicialLabel,
            'Data',
            readOnly: true,
            onTapCallback: () => _callbackDataInicial(),
          ),
          Editor(
            _controladorCampoDataFinal,
            DataAnalysis._dataFinalLabel,
            'Data',
            readOnly: true,
            onTapCallback: () => _callbackDataFinal(),
          ),
          Expanded(
            child: StreamBuilder<Map<Categoria, double>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  }
                  _mapCategoriaValor = snapshot.data!;
                  if (_mapCategoriaValor.isEmpty) {
                    return const Text("Não há gastos no período");
                  }
                  return _listBuilder();
                }),
          ),
        ],
      ),
    );
  }

  ListView _listBuilder() {
    return ListView.builder(
      itemCount: _mapCategoriaValor.length,
      itemBuilder: (context, indice) {
        final Categoria categoria = _mapCategoriaValor.keys.elementAt(indice);
        ItemAnalysis itemAnalysis;
        double valorCategoria = 0;
        if (categoria == null) {
          itemAnalysis = ItemAnalysis(
              valorCategoria, 0, Categoria('Unknown Error', Colors.red));
        } else {
          valorCategoria = _mapCategoriaValor[categoria]!;
          itemAnalysis = ItemAnalysis(valorCategoria,
              (_mapCategoriaValor[categoria]! / _valorTotal) * 100, categoria);
        }
        return GestureDetector(
          onLongPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Moedas(valorCategoria);
            }));
          },
          child: itemAnalysis,
        );
      },
    );
  }

  Future<DateTime?> _showDatePicker(DateTime initialDate) async {
    DateTime lastDate = DateTime.now();
    if (initialDate.isAfter(lastDate)) {
      lastDate = initialDate;
    }
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: lastDate,
    );
  }

  void _callbackDataInicial() {
    _showDatePicker(_dataInicial).then((date) => {
          if (date != null)
            {
              setState(() {
                _dataInicial = date;
                _controladorCampoDataInicial.text =
                    _formatter.format(_dataInicial);
                loadLista();
              })
            }
        });
    return;
  }

  void _callbackDataFinal() {
    _showDatePicker(_dataFinal).then((date) => {
          if (date != null)
            {
              setState(() {
                _dataFinal = date;
                _controladorCampoDataFinal.text = _formatter.format(_dataFinal);
                loadLista();
              })
            }
        });
  }
}
