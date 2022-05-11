import 'package:flutter/material.dart';
import 'centered_text.dart';

class DefaultContainer extends StatelessWidget {
  final String _text;
  static const double _padding = 20.0;
  static const double _margin = 20.0;
  static const double _bottomMargin = 0.0;
  static const double _radius = 20.0;

  const DefaultContainer(this._text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CenteredText(_text),
      padding: const EdgeInsets.all(_padding),
      margin: const EdgeInsets.fromLTRB(_margin, _margin, _margin, _bottomMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        color: Theme.of(context).cardColor,
      ),
    );
  }

}