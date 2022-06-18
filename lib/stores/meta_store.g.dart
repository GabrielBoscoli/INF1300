// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MetaStore on _MetaStore, Store {
  late final _$metaAtom = Atom(name: '_MetaStore.meta', context: context);

  @override
  int get meta {
    _$metaAtom.reportRead();
    return super.meta;
  }

  @override
  set meta(int value) {
    _$metaAtom.reportWrite(value, super.meta, () {
      super.meta = value;
    });
  }

  late final _$atualAtom = Atom(name: '_MetaStore.atual', context: context);

  @override
  int get atual {
    _$atualAtom.reportRead();
    return super.atual;
  }

  @override
  set atual(int value) {
    _$atualAtom.reportWrite(value, super.atual, () {
      super.atual = value;
    });
  }

  late final _$loadMetaAsyncAction =
      AsyncAction('_MetaStore.loadMeta', context: context);

  @override
  Future<void> loadMeta() {
    return _$loadMetaAsyncAction.run(() => super.loadMeta());
  }

  late final _$updateMetaAsyncAction =
      AsyncAction('_MetaStore.updateMeta', context: context);

  @override
  Future<void> updateMeta(int meta) {
    return _$updateMetaAsyncAction.run(() => super.updateMeta(meta));
  }

  late final _$_MetaStoreActionController =
      ActionController(name: '_MetaStore', context: context);

  @override
  void addAtual(DateTime date, int value) {
    final _$actionInfo =
        _$_MetaStoreActionController.startAction(name: '_MetaStore.addAtual');
    try {
      return super.addAtual(date, value);
    } finally {
      _$_MetaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void subAtual(DateTime date, int value) {
    final _$actionInfo =
        _$_MetaStoreActionController.startAction(name: '_MetaStore.subAtual');
    try {
      return super.subAtual(date, value);
    } finally {
      _$_MetaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meta: ${meta},
atual: ${atual}
    ''';
  }
}
