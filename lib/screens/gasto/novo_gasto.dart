import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/seletor_categoria.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'formulario_gasto.dart';

class NovoGasto extends StatelessWidget {
  static const _title = 'Novo Gasto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: FormularioGasto(gasto: null,),
    );
  }
}