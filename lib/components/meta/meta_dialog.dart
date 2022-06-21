import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../stores/meta_store.dart';
import '../geral/editor.dart';

class MetaDialog extends StatefulWidget {
  static const String _metaAtual = 'Meta mensal atual: ';
  static const String _metaMedia = 'Meta media entre usuarios: ';
  static const String _metaNova = 'Meta nova';

  @override
  State<StatefulWidget> createState() => _MetaDialogState();
}

class _MetaDialogState extends State<MetaDialog> {
  final TextEditingController _controladorCampoValor = TextEditingController();
  late MetaStore metaStore;
  bool _camposPreenchidos = false;

  @override
  void initState() {
    super.initState();
    _controladorCampoValor.addListener(() {
      _atualizaBotaoConfirmar();
    });
  }

  @override
  Widget build(BuildContext context) {
    metaStore = Provider.of<MetaStore>(context);
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              MetaDialog._metaAtual + metaStore.meta.toString(),
              textAlign: TextAlign.center,
            ),
            Text(
              metaStore.mediaMeta == -1 ? '' : MetaDialog._metaMedia + metaStore.mediaMeta.toString(),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Editor(
              _controladorCampoValor,
              MetaDialog._metaNova,
              '',
              icone: Icons.monetization_on,
              textInputType: TextInputType.number,
            ),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: _camposPreenchidos ? () => _confirmedPressed() : null,
            ),
          ],
        ),
      ),
    );
  }

  void _confirmedPressed() {
    debugPrint('confirmedPressed');
    final double? valor =
        double.tryParse(_controladorCampoValor.text.replaceAll(',', '.'));
    if (valor != null && valor >= 0) {
      metaStore.updateMeta(valor.round());
    }
    Navigator.pop(context);
  }

  void _atualizaBotaoConfirmar() {
    setState(() {
      _camposPreenchidos = _controladorCampoValor.text.isNotEmpty;
    });
  }
}
