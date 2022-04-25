import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/screens/gasto/categoria/nova_categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SeletorCategoria extends StatefulWidget {
  final List<Categoria> categorias = [
    Categoria('Bebida', Colors.red),
    Categoria('Comida', Colors.blue),
    Categoria('Carro', Colors.green),
  ];
  final Function _onChangedCallback;

  SeletorCategoria(this._onChangedCallback, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeletorCategoriaState();
  }
}

class SeletorCategoriaState extends State<SeletorCategoria> {
  Categoria? dropdownValue;
  late final unselectedColor = Theme.of(context).scaffoldBackgroundColor;
  late Color selectedColor = unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                      setState(()  {
                        _atualizaSeletor(categoria);
                        widget._onChangedCallback(categoria);
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
              padding: const EdgeInsets.only(right: 16.0),
              child: ColorIndicator(HSVColor.fromColor(selectedColor)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Future<Categoria?> future = Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NovaCategoria();
              }),
            );
            future.then((categoria) {
              debugPrint('categoria recebida: $categoria');
              setState(() {
                _atualizaSeletor(categoria);
                widget._onChangedCallback(categoria);
                if (categoria != null) {
                  widget.categorias.add(categoria);
                }
              });
            });
          },
          child: const Text(
            'Nova Categoria +',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  void _atualizaSeletor(Categoria? categoria) {
    dropdownValue = categoria;
    if (categoria != null) {
      selectedColor = categoria.color;
    } else {
      selectedColor = unselectedColor;
    }
  }
}
