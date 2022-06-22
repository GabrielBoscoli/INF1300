import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/dao/gasto_dao.dart';
import '../services/firebase_service.dart';
part 'meta_store.g.dart';

class MetaStore = _MetaStore with _$MetaStore;

abstract class _MetaStore with Store {
  late SharedPreferences _prefs;
  final GastoDao _gastoDao = const GastoDao();
  final _dataCorrente = DateTime.now();
  late final DateTime _dataInicial =
      DateTime(_dataCorrente.year, _dataCorrente.month, 1);
  late final DateTime _dataFinal = DateTime(_dataCorrente.year, _dataCorrente.month + 1, 0);
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  late String? userId;
  // nao há necessidade de atualizacao em tempo real. pode ser apenas quando inicializa o meta store.
  // -1 se nao conseguir pegar a media do firebase.
  int mediaMeta = -1;
  final String _metaString = 'meta';
  final String _idString = 'id';
  FirebaseService fbService = FirebaseService();

  @observable
  int meta = 1000;

  @observable
  int atual = 0;

  _MetaStore() {
    _initMetaStore();
  }

  @action
  Future<void> loadMeta() async {
    meta = _prefs.getInt(_metaString) ?? 0;
    userId = _prefs.getString(_idString);
    double atualDouble = await _gastoDao
        .findTotalByDate(DateTimeRange(start: _dataInicial, end: _dataFinal));
    atual = atualDouble.toInt();
    mediaMeta = await fbService.getMediaMeta();
  }

  @action
  Future<void> updateMeta(int meta) async {
    userId ??= await fbService.createUserId();
    fbService.updateMeta(userId!, meta, this.meta);
    this.meta = meta;
    _prefs.setInt(_metaString, meta);
    _prefs.setString(_idString, userId!);
  }

  @action
  void addAtual(DateTime date, int value) {
    if (date.month == _dataCorrente.month && date.year == _dataCorrente.year) {
      atual += value;
    }
  }

  @action
  void subAtual(DateTime date, int value) {
    if (date.month == _dataCorrente.month && date.year == _dataCorrente.year) {
      atual -= value;
    }
  }

  void _initMetaStore() async {
    await _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await loadMeta();
  }
}
