import 'package:equatable/equatable.dart';
import 'categoria.dart';

class Gasto extends Equatable {
  int id;
  final double valor;
  final String descricao;
  final Categoria categoria;
  final DateTime data;

  Gasto(this.id, this.valor, this.descricao, this.categoria, this.data);

  @override
  String toString() {
    return 'Gasto{id: $id, valor: $valor, descricao: $descricao, categoria: $categoria, data: $data}';
  }

  @override
  List<Object?> get props => [id];
}