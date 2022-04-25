import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/seletor_categoria.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioGasto extends StatefulWidget {
  final GastoDao _gastoDao = GastoDao();

  FormularioGasto({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioGastoState();
  }
}

class FormularioGastoState extends State<FormularioGasto> {
  final TextEditingController _controladorCampoDescricao =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final DateFormat _formatter = DateFormat('dd-MM-yyyy');
  late final TextEditingController _controladorCampoData =
      TextEditingController(text: _formatter.format(_selectedDate));
  Categoria? _selectedCategoria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Gasto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SeletorCategoria(_callbackSeletorCategoria),
            Editor(
              _controladorCampoData,
              'Data',
              'Data',
              readOnly: true,
              onTapCallback: () => _callbackDatePicker(),
            ),
            Editor(
              _controladorCampoValor,
              'Valor',
              '0.00',
              icone: Icons.monetization_on,
              textInputType: TextInputType.number,
            ),
            Editor(
              _controladorCampoDescricao,
              'Descrição',
              'Breve descrição do gasto.',
              maxLines: 5,
            ),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () => _criaGasto(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaGasto(BuildContext context) {
    final String? descricao = _controladorCampoDescricao.text;
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (valor != null && _selectedCategoria != null) {
      final Gasto novoGasto = Gasto(
        1,
        valor,
        descricao!,
        _selectedCategoria!,
        _selectedDate,
      );
      debugPrint('Criando gasto');
      debugPrint('$novoGasto');
      widget._gastoDao.save(novoGasto);
      Navigator.pop(context);
    } else {
      debugPrint('Nao criou gasto');
    }
  }

  void _callbackDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
          _controladorCampoData.text = _formatter.format(_selectedDate);
        });
      }
    });
  }

  void _callbackSeletorCategoria(Categoria? categoria) {
    _selectedCategoria = categoria;
  }
}
