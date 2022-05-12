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
  late final bool edit = gasto == null ? false : true;

  FormularioGasto({Key? key, this.gasto}) : super(key: key);

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
  late DateTime _selectedDate = widget.gasto != null ? widget.gasto!.data : DateTime.now();
  final DateFormat _formatter = DateFormat('dd-MM-yyyy');
  late final TextEditingController _controladorCampoData = widget.gasto == null
      ? TextEditingController(text: _formatter.format(_selectedDate))
      : TextEditingController(text: _formatter.format(widget.gasto!.data));
  late Categoria? _selectedCategoria = widget.gasto != null ? widget.gasto!.categoria : null;
  late bool _camposPreenchidos = widget.gasto != null ? true : false;

  @override
  void initState() {
    super.initState();
    _controladorCampoDescricao.addListener(() { _atualizaBotaoConfirmar();});
    _controladorCampoValor.addListener(() { _atualizaBotaoConfirmar();});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              onPressed: _camposPreenchidos ? () => _criaGasto(context) : null,
            )
          ],
        ),
      );
  }

  void _criaGasto(BuildContext context) {
    final String? descricao = _controladorCampoDescricao.text;
    final double? valor = double.tryParse(_controladorCampoValor.text.replaceAll(',', '.'));
    if (valor != null && _selectedCategoria != null) {
      final Gasto novoGasto = Gasto(
        1,
        valor,
        descricao!,
        _selectedCategoria!,
        _selectedDate,
      );
      if (widget.edit) {
        novoGasto.id = widget.gasto!.id;
        widget._gastoDao.update(novoGasto);
      } else {
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
    _atualizaBotaoConfirmar();
  }

  void _atualizaBotaoConfirmar() {
    setState(() {
      _camposPreenchidos = _controladorCampoDescricao.text.isNotEmpty &&
          _controladorCampoValor.text.isNotEmpty && _selectedCategoria != null;
    });
  }
}
