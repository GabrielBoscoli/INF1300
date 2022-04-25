import 'categoria.dart';

class Gasto {
  final int id;
  final double valor;
  final String descricao;
  final Categoria categoria;
  final DateTime data;

  Gasto(this.id, this.valor, this.descricao, this.categoria, this.data);

  @override
  String toString() {
    return 'Gasto{id: $id, valor: $valor, descricao: $descricao, categoria: $categoria, data: $data}';
  }
}