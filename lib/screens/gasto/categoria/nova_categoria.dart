import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/categoria_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NovaCategoria extends StatefulWidget {
  NovaCategoria({Key? key}) : super(key: key);

  @override
  State<NovaCategoria> createState() => _NovaCategoriaState();
}

class _NovaCategoriaState extends State<NovaCategoria> {
  final TextEditingController _controller = TextEditingController();
  Color? selectedColor;
  final CategoriaDao categoriaDao = CategoriaDao();
  bool _camposPreenchidos = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _atualizaBotaoConfirmar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Categoria'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(_controller, 'Nome', 'Exemplo: Comida'),
            BlockPicker(
              pickerColor: Theme.of(context).scaffoldBackgroundColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
                _atualizaBotaoConfirmar();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text('Confirmar'),
                onPressed:
                    _camposPreenchidos ? () => _criaCategoria(context) : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _criaCategoria(BuildContext context) {
    debugPrint('confirmou nova categoria');
    Categoria? categoria;
    if (_controller.text.isNotEmpty && selectedColor != null) {
      categoria = Categoria(_controller.text, selectedColor!);
      categoriaDao.save(categoria).then((value) {
        if (value == 0) {
          categoria = null;
        }
        Navigator.pop(context, categoria);
      });
    }
  }

  void _atualizaBotaoConfirmar() {
    setState(() {
      _camposPreenchidos = _controller.text.isNotEmpty && selectedColor != null;
    });
  }
}
