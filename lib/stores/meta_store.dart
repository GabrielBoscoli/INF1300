import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/dao/gasto_dao.dart';
part 'meta_store.g.dart';

class MetaStore = _MetaStore with _$MetaStore;

abstract class _MetaStore with Store {
  late SharedPreferences _prefs;
  final GastoDao _gastoDao = const GastoDao();
  final _dataCorrente = DateTime.now();
  late final DateTime _dataInicial =
      DateTime(_dataCorrente.year, _dataCorrente.month, 1);
  late final DateTime _dataFinal = DateTime(_dataCorrente.year, _dataCorrente.month + 1, 0);

  @observable
  int meta = 1000;

  @observable
  int atual = 0;

  _MetaStore() {
    _initMetaStore();
  }

  @action
  Future<void> loadMeta() async {
    meta = _prefs.getInt('meta') ?? 0;
    double atualDouble = await _gastoDao
        .findTotalByDate(DateTimeRange(start: _dataInicial, end: _dataFinal));
    atual = atualDouble.toInt();
  }

  @action
  Future<void> updateMeta(int meta) async {
    this.meta = meta;
    _prefs.setInt('meta', meta);
  }

  @action
  void addAtual(int value) {
    atual += value;
  }

  @action
  void subAtual(int value) {
    atual -= value;
  }

  void _initMetaStore() async {
    await _initPrefs();
  }

  Future<void> _initPrefs() async {
    debugPrint('init prefs');
    _prefs = await SharedPreferences.getInstance();
    await loadMeta();
    debugPrint('init prefs end');
  }
}
