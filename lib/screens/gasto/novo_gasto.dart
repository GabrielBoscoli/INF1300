import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/seletor_categoria.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioGasto extends StatefulWidget {
  final GastoDao _gastoDao = GastoDao();
  final Gasto? gasto;
  final String? appBarTitle;
  final IconButton? iconButton;

  /// se o formulario é para edicao de um gasto ou criacao de um novo.
  late final bool edit = gasto == null ? false : true;

  FormularioGasto({Key? key, this.gasto, this.appBarTitle, this.iconButton}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioGastoState();
  }
}

class FormularioGastoState extends State<FormularioGasto> {
  late final TextEditingController _controladorCampoDescricao =
      widget.gasto == null
          ? TextEditingController()
          : TextEditingController(text: widget.gasto!.descricao);
  late final TextEditingController _controladorCampoValor = widget.gasto == null
      ? TextEditingController()
      : TextEditingController(text: widget.gasto!.valor.toString());
  DateTime _selectedDate = DateTime.now();
  final DateFormat _formatter = DateFormat('dd-MM-yyyy');
  late final TextEditingController _controladorCampoData = widget.gasto == null
      ? TextEditingController(text: _formatter.format(_selectedDate))
      : TextEditingController(text: _formatter.format(widget.gasto!.data));
  late Categoria? _selectedCategoria = widget.gasto != null ? widget.gasto!.categoria : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle == null
            ? const Text('Novo Gasto')
            : Text(widget.appBarTitle!),
        actions: <Widget>[
          widget.iconButton == null
              ? const SizedBox()
              : widget.iconButton!,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            widget.gasto == null
                ? SeletorCategoria(_callbackSeletorCategoria)
                : SeletorCategoria(_callbackSeletorCategoria,
                    categoria: widget.gasto!.categoria),
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
      if (widget.edit) {
        debugPrint('update gasto');
        novoGasto.id = widget.gasto!.id;
        widget._gastoDao.update(novoGasto);
      } else {
        debugPrint('save gasto');
        widget._gastoDao.save(novoGasto).then((value) {
          novoGasto.id = value;
        });
      }
      Navigator.pop(context, novoGasto);
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
