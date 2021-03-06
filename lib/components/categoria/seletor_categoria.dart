import 'package:bytebank/database/dao/categoria_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SeletorCategoria extends StatefulWidget {
  final Function _onChangedCallback;
  final CategoriaDao _categoriaDao = const CategoriaDao();
  final Categoria? categoria;

  const SeletorCategoria(this._onChangedCallback, {Key? key, this.categoria}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SeletorCategoriaState();
  }
}

class SeletorCategoriaState extends State<SeletorCategoria> {
  Categoria? _dropdownValue;
  late final _unselectedColor = Theme.of(context).scaffoldBackgroundColor;
  late Color _selectedColor = _unselectedColor;
  late Future<List<Categoria>>? _futureCategorias;
  late List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _futureCategorias = widget._categoriaDao.findAll();
    if (widget.categoria != null) {
      _categorias.add(widget.categoria!);
      _atualizaSeletor(widget.categoria!);
    }
  }

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
                    child: FutureBuilder<List<Categoria>>(
                        initialData: const [],
                        future: _futureCategorias,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              if (snapshot.data != null) {
                                _categorias = snapshot.data!;
                              }
                              _futureCategorias = null;
                              break;
                            default:
                              break;
                          } // switch
                          return DropdownButtonFormField<Categoria>(
                            value: _dropdownValue,
                            style: const TextStyle(fontSize: 24.0),
                            items: _categorias.map((categoria) {
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
                          );
                        })),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ColorIndicator(HSVColor.fromColor(_selectedColor)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            final Future future = Navigator.pushNamed(
              context,
              '/novacategoria',
            );
            future.then((categoria) {
              setState(() {
                _atualizaSeletor(categoria);
                widget._onChangedCallback(categoria);
                if (categoria != null) {
                  _categorias.add(categoria);
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
    _dropdownValue = categoria;
    if (categoria != null) {
      _selectedColor = categoria.color;
    } else {
      _selectedColor = _unselectedColor;
    }
  }
}
