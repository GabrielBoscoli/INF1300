import 'package:bytebank/components/meta/meta_dialog.dart';
import 'package:bytebank/stores/meta_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MetaAppBarText extends StatefulWidget {
  static const String _metaAtual = 'Meta atual: ';
  static const String _metaNova = 'Meta nova: ';

  @override
  State<MetaAppBarText> createState() => _MetaAppBarTextState();
}

class _MetaAppBarTextState extends State<MetaAppBarText> {
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
    return TextButton(
      onPressed: () {
        metaStore.subAtual(1);
        showDialog(
            context: context,
            builder: (context) {
              return MetaDialog();
            });
      },
      child: Observer(
        builder: (_) =>
            Text(metaStore.atual.toString() + '/' + metaStore.meta.toString()),
      ),
    );
  }
}
