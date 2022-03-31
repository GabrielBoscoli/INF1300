import 'package:bytebank/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SeletorCategoria extends StatefulWidget {
  final List<Categoria> categorias = [
    Categoria('Bebida', Colors.red),
    Categoria('Comida', Colors.blue),
    Categoria('Carro', Colors.green),
  ];

  SeletorCategoria({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeletorCategoriaState();
  }
}

class SeletorCategoriaState extends State<SeletorCategoria> {
  Categoria? dropdownValue;
  late Color selectedColor = Theme.of(context).scaffoldBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<Categoria>(
                value: dropdownValue,
                style: const TextStyle(fontSize: 24.0),
                items: widget.categorias.map((categoria) {
                  return DropdownMenuItem<Categoria>(
                    value: categoria,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(categoria.name),
                    ),
                  );
                }).toList(),
                onChanged: (categoria) {
                  setState(() {
                    dropdownValue = categoria!;
                    selectedColor = categoria.color;
                  });
                },
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  labelStyle: TextStyle(fontSize: 24.0),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ColorIndicator(HSVColor.fromColor(selectedColor)),
        ),
      ],
    );
  }
}
