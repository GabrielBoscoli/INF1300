import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String? description;

  const YesNoDialog({Key? key, required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description ?? ''),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No')),
      ],
    );
  }
}
