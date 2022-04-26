import 'package:bytebank/models/gasto.dart';
import 'package:bytebank/screens/gasto/editar_gasto.dart';
import 'package:flutter/material.dart';

class ItemGasto extends StatefulWidget {
  Gasto _gasto;
  final void Function(Gasto gasto)? deleteCallback;

  ItemGasto(this._gasto, {Key? key, this.deleteCallback}) : super(key: key);

  @override
  State<ItemGasto> createState() => _ItemGastoState();
}

class _ItemGastoState extends State<ItemGasto> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.arrow_circle_down_rounded,
                    size: 32,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.monetization_on_rounded,
                    size: 32,
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ],
          ),
          title: Column(
            children: [
              Chip(
                label: Text(widget._gasto.categoria.name),
                backgroundColor: widget._gasto.categoria.color,
              ),
              Text(widget._gasto.valor.toString()),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          subtitle: Text(widget._gasto.descricao),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalDivider(thickness: 1.5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget> [
                  IconButton(onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return FormularioEdicao(widget._gasto, deleteCallback: widget.deleteCallback,);
                    })).then((value) {
                      setState(() {
                        if (value != null) {
                          widget._gasto = value;
                        }
                      });
                    })
                  }, icon: const Icon(Icons.edit),),
                ],
              ),
            ],
          ),
        ));
  }
}
