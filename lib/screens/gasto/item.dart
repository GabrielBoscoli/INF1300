import 'package:bytebank/models/gasto.dart';
import 'package:bytebank/screens/gasto/editar_gasto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemGasto extends StatefulWidget {
  Gasto _gasto;
  final void Function(Gasto gasto)? deleteCallback;
  final void Function(Gasto gasto)? editCallback;
  static const int _fractionDigits = 2;

  ItemGasto(this._gasto, {Key? key, this.deleteCallback, this.editCallback})
      : super(key: key);

  @override
  State<ItemGasto> createState() => _ItemGastoState();
}

class _ItemGastoState extends State<ItemGasto> {
  final DateFormat _formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.arrow_circle_down_rounded,
                  size: 32,
                  color: Colors.red,
                ),
                Icon(
                  Icons.monetization_on_rounded,
                  size: 32,
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ],
        ),
        title: Column(
          children: [
            Chip(
              label: Text(
                widget._gasto.categoria.name,
              ),
              backgroundColor: widget._gasto.categoria.color,
            ),
            Text(
              'R\$ ${widget._gasto.valor.toStringAsFixed(ItemGasto._fractionDigits)} (${_formatter.format(widget._gasto.data)})',
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        subtitle: Text(widget._gasto.descricao),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VerticalDivider(
              thickness: 1.5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormularioEdicao(
                        widget._gasto,
                        deleteCallback: widget.deleteCallback,
                      );
                    })).then((gastoEditado) {
                      if (gastoEditado != null) {
                        setState(() {
                          widget._gasto = gastoEditado;
                        });
                        if (widget.editCallback != null) {
                          widget.editCallback!(gastoEditado);
                        }
                      }
                    })
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
