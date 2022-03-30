import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FormularioGasto extends StatefulWidget {
  const FormularioGasto({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return FormularioGastoState();
  }

}

class FormularioGastoState extends State<FormularioGasto> {

  final TextEditingController _controladorCampoCategoria =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  final Color _defaultColor = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo Gasto'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                    child: Editor(
                      _controladorCampoCategoria,
                      'Categoria',
                      'Exemplo: Comida',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ColorIndicator(HSVColor.fromColor(_defaultColor)),
                  ),
                ],
              ),
              Editor(
                _controladorCampoValor,
                'Valor',
                '0.00',
                icone: Icons.monetization_on,
              ),
              Editor(
                _controladorCampoCategoria,
                'Descrição',
                'Breve descrição do gasto.',
                maxLines: 5,
              ),
              // MaterialPicker(pickerColor: const Color(0xFFFFFFFF), onColorChanged: (color) {}),
              // MultipleChoiceBlockPicker(pickerColors: const [Color(0xFFFFFFFF)], onColorsChanged: (color) {}, useInShowDialog: true,),
              // ColorPicker(pickerColor: const Color(0xFFFFFFFF), onColorChanged: (color) {}),
              // ColorPickerLabel(HSVColor.fromColor(const Color(0xFFFFFFFF))),
              // BlockPicker(pickerColor: const Color(0xFFFFFFFF), onColorChanged: (color) {}),
              // ColorIndicator(HSVColor.fromColor(const Color(0xFFFFFFFF))),
              ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () => _criaGasto(context),
              )
            ],
          ),
        ));
  }

  void _criaGasto(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoCategoria.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final Gasto gastoCriado = Gasto(valor, numeroConta, Categoria('default categoria', Colors.teal));
      debugPrint('Criando gasto');
      debugPrint('$gastoCriado');
      Navigator.pop(context, gastoCriado);
    }
  }
}