import 'package:bytebank/components/geral/yes_no_dialog.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';

import '../../components/meta/meta_appbar_text.dart';
import 'formulario_gasto.dart';

/// Formulario de edicao de um gasto.
class FormularioEdicao extends StatelessWidget {
  final Gasto _gasto;
  final GastoDao _gastoDao = const GastoDao();
  final void Function(Gasto gasto)? deleteCallback;

  static const String _title = 'Editar Gasto';

  const FormularioEdicao(this._gasto, {Key? key, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: [
          MetaAppBarText(),
          IconButton(
            onPressed: () {
              showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const YesNoDialog(
                      title: 'Deletar transação',
                      description:
                      'Essa ação é irreversível. Tem certeza que deseja deletar esta transação?',
                    );
                  }).then((value) {
                if (value != null && value) {
                  _gastoDao.delete(_gasto.id);
                  if (deleteCallback != null) {
                    deleteCallback!(_gasto);
                  }
                  Navigator.pop(context, null);
                }
              });
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      body: FormularioGasto(gasto: _gasto,),
    );
  }
}
