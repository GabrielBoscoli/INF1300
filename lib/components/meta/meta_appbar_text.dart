import 'package:bytebank/components/meta/meta_dialog.dart';
import 'package:bytebank/stores/meta_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MetaAppBarText extends StatefulWidget {
  static const String _metaAtual = 'Meta atual: ';
  static const String _metaNova = 'Meta nova: ';

  @override
  State<MetaAppBarText> createState() => _MetaAppBarTextState();
}

class _MetaAppBarTextState extends State<MetaAppBarText> {

  @override
  Widget build(BuildContext context) {
    final metaStore = Provider.of<MetaStore>(context);
    return TextButton(
      onPressed: () {
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
