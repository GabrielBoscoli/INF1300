import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/categoria_dao.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NovaCategoria extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  Color? selectedColor;
  final CategoriaDao categoriaDao = CategoriaDao();

  NovaCategoria({Key? key}) : super(key: key);

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
                selectedColor = color;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  debugPrint('confirmou nova categoria');
                  Categoria? categoria;
                  if (_controller.text.isNotEmpty && selectedColor != null) {
                    categoria = Categoria(_controller.text, selectedColor!);
                    categoriaDao.save(categoria);
                    Navigator.pop(context, categoria);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
