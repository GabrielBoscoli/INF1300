import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ItemGasto extends StatelessWidget {
  final Gasto _gasto;

  const ItemGasto(this._gasto, {Key? key}) : super(key: key);

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
            label: Text(_gasto.categoria.name),
            backgroundColor: _gasto.categoria.color,
          ),
          Text(_gasto.valor.toString()),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      subtitle: Text(_gasto.descricao),
    ));
  }
}
