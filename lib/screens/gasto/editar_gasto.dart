import 'package:bytebank/components/yes_no_dialog.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:bytebank/screens/gasto/novo_gasto.dart';
import 'package:flutter/material.dart';

/// Formulario de edicao de um gasto.
class FormularioEdicao extends StatelessWidget {
  final Gasto _gasto;
  final GastoDao _gastoDao = const GastoDao();

  /// método que será chamado ao deletar o gasto.
  final void Function(Gasto gasto)? deleteCallback;

  static const String _appBarTitle = 'Editar Gasto';

  const FormularioEdicao(this._gasto, {Key? key, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return FormularioGasto(
      gasto: _gasto,
      appBarTitle: _appBarTitle,
      iconButton: IconButton(
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
              debugPrint('deletando transação do banco de dados...');
              _gastoDao.delete(_gasto.id);
              debugPrint('transação deletada');
              if (deleteCallback != null) {
                deleteCallback!(_gasto);
              }
              Navigator.pop(context, _gasto);
            }
          });
        },
        icon: const Icon(Icons.delete_forever_rounded),
      ),
    );
  }
}
