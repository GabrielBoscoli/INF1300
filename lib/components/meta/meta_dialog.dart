import 'package:flutter/material.dart';
import '../../stores/meta_store.dart';
import '../geral/editor.dart';

class MetaDialog extends StatefulWidget {
  static const String _metaAtual = 'Meta atual: ';
  static const String _metaNova = 'Meta nova: ';

  @override
  State<StatefulWidget> createState() => _MetaDialogState();

}class _MetaDialogState extends State<MetaDialog> {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final MetaStore metaStore = MetaStore();

  @override
  void initState() {
    super.initState();
    _controladorCampoValor.addListener(() {
      //_atualizaBotaoConfirmar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(MetaDialog._metaAtual + metaStore.meta.toString()),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(MetaDialog._metaNova),
            Editor(
              _controladorCampoValor,
              'Valor',
              '0.00',
              icone: Icons.monetization_on,
              textInputType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
