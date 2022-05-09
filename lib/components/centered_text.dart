import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;

  const CenteredText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

}