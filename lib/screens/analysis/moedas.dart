import 'package:bytebank/api/cotacao_api.dart';
import 'package:bytebank/components/geral/default_container.dart';
import 'package:flutter/material.dart';
import '../../api/post.dart';
import '../../components/geral/loading.dart';

class Moedas extends StatefulWidget {
  final double _valor;
  final CotacaoAPI cotacaoAPI = CotacaoAPI();
  static const int _itemFractionDigits = 4;
  static const int _titleFractionDigits = 2;

  Moedas(this._valor, {Key? key}) : super(key: key);

  @override
  State<Moedas> createState() => _MoedasState();
}

class _MoedasState extends State<Moedas> {
  late Future<Post>? _futurePost;
  late final Post _post;

  @override
  void initState() {
    super.initState();
    try {
      _futurePost = widget.cotacaoAPI.fetchPost();
    } catch(e) {
      debugPrint("Erro ao buscar dados da api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R\$ ${widget._valor.toStringAsFixed(Moedas._titleFractionDigits)}'),
      ),
      body: FutureBuilder<Post>(
        future: _futurePost,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _listBuilder();
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data == null) {
                return const SizedBox();
              }
              _post = snapshot.data!;
              _futurePost = null;
              return _listBuilder();
          }
          return const Text('Unknown error');
        },
      )
    );
  }

  ListView _listBuilder() {
    const double bottomListPadding = 20.0;
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: bottomListPadding),
      itemCount: Post.numMoedas,
      itemBuilder: (context, indice) {
        final String currencyName = _post.getCurrencies().elementAt(indice);
        final double currencyValue = _post.getValueFromCurrency(currencyName) * widget._valor;
        return DefaultContainer(
          '$currencyName: ${currencyValue.toStringAsFixed(Moedas._itemFractionDigits)}',
        );
      },
    );
  }
}
