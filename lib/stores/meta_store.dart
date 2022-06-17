import 'package:mobx/mobx.dart';
part 'meta_store.g.dart';

class MetaStore = _MetaStore with _$MetaStore;

abstract class _MetaStore with Store {
  @observable
  int meta = 1000;

  @observable
  int atual = 0;

  @action
  void updateMeta(int meta) {
    this.meta = meta;
  }

  @action
  void addAtual(int value) {
    this.atual += value;
  }

  @action
  void subAtual(int value) {
    this.atual -= value;
  }
}