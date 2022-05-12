import 'package:bytebank/components/centered_text.dart';
import 'package:flutter/material.dart';

import '../../models/categoria.dart';

class ItemAnalysis extends StatelessWidget {
  final double valor;
  final double porcentagem;
  final Categoria categoria;
  static const double _dividerThickness = 1.5;
  static const double _indent = 10.0;
  static const VerticalDivider _customVerticalDivider = VerticalDivider(
    thickness: _dividerThickness,
    indent: _indent,
    endIndent: _indent,
  );
  static const double _cardHeight = 90.0;
  static const int _fractionDigits = 2;

  const ItemAnalysis(this.valor, this.porcentagem, this.categoria, {Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: _cardHeight,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Chip(
                label: CenteredText(
                  categoria.name,
                ),
                backgroundColor: categoria.color,
              ),
            ),
            _customVerticalDivider,
            Expanded(
              child: CenteredText(
                'R\$ ${valor.toStringAsFixed(_fractionDigits)}',
              ),
            ),
            _customVerticalDivider,
            Expanded(
              child: CenteredText(
                '${porcentagem.toStringAsFixed(_fractionDigits)}%',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
