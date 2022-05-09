import 'package:bytebank/components/loading.dart';
import 'package:bytebank/screens/analysis/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/editor.dart';
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
      // DateTime(_dataCorrente.year, _dataCorrente.month + 1, 0);
      // isso colocaria a data no ultimo dia do mes corrente

  final DateFormat _formatter = DateFormat('dd-MM-yyyy');

  late final _controladorCampoDataInicial =
      TextEditingController(text: _formatter.format(_dataInicial));

  late final _controladorCampoDataFinal =
      TextEditingController(text: _formatter.format(_dataFinal));

  late Future<Map<Categoria, double>>? _futureMap;

  Map<Categoria, double> _mapCategoriaValor = {};

  double _valorTotal = 0;

  @override
  void initState() {
    debugPrint('data analysis init state...');
    super.initState();
    DataAnalysis._gastoDao.findTotalByDate(DateTimeRange(start: _dataInicial, end: _dataFinal)).then((value) {
      debugPrint('init state then value: ' + value.toString());
      setState(() {
        _valorTotal = value;
      });
    });
    _futureMap = DataAnalysis._gastoDao.findByDateGroupedByCategoria(
        DateTimeRange(start: _dataInicial, end: _dataFinal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(DataAnalysis._appBarTitle)),
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
            /// tem que ter esse expanded se nao a lista nao renderiza
            child: FutureBuilder<Map<Categoria, double>>(
                future: _futureMap,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      debugPrint('data analysis connection state none');
                      return _listBuilder();
                    case ConnectionState.active:
                      debugPrint('data analysis connection state active');
                      break;
                    case ConnectionState.waiting:
                      debugPrint('data analysis connection state waiting');
                      return Loading();
                    case ConnectionState.done:
                      debugPrint('data analysis connection state done');
                      _mapCategoriaValor = snapshot.data ?? {};
                      return _listBuilder();
                  }
                  return const Text('Unknown error');
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
        if (categoria == null) {
          return ItemAnalysis(0.0, 0, Categoria('Unknown Error', Colors.red));
        }
        return ItemAnalysis(_mapCategoriaValor[categoria]!,
            (_mapCategoriaValor[categoria]! / _valorTotal) * 100, categoria);
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
                _futureMap = DataAnalysis._gastoDao
                    .findByDateGroupedByCategoria(
                        DateTimeRange(start: _dataInicial, end: _dataFinal));
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
                _futureMap = DataAnalysis._gastoDao
                    .findByDateGroupedByCategoria(
                        DateTimeRange(start: _dataInicial, end: _dataFinal));
              })
            }
        });
  }
}
