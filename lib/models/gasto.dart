import 'categoria.dart';

class Gasto {
  final double valor;
  final int numeroConta;
  final Categoria categoria;

  Gasto(this.valor, this.numeroConta, this.categoria);

  @override
  String toString() {
    return 'Gasto{valor: $valor, numeroConta: $numeroConta, categoria: $categoria}';
  }
}