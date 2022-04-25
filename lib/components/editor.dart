import 'package:flutter/material.dart';

/// Classe que representa um campo de input de texto.
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  final int? maxLines;
  final TextInputType? textInputType;
  final bool readOnly;
  final Function? onTapCallback;

  const Editor(this.controlador, this.rotulo, this.dica,
      {this.icone, this.maxLines, this.textInputType, this.readOnly = false, this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        readOnly: readOnly,
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
        ),
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLines,
        onTap: onTapCallback != null ? () => onTapCallback!() : null,
      ),
    );
  }
}
