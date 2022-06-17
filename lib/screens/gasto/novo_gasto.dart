import 'package:flutter/material.dart';
import '../../components/meta/meta_appbar_text.dart';
import 'formulario_gasto.dart';

class NovoGasto extends StatelessWidget {
  static const _title = 'Novo Gasto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MetaAppBarText(),
        ],
        title: const Text(_title),
      ),
      body: FormularioGasto(gasto: null,),
    );
  }
}