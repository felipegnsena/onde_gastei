import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/database.dart';
import 'package:flutter_crud/data/dummy_finantial_records.dart';
import 'package:flutter_crud/models/financial_record.dart';

class FinancialRecordProvider with ChangeNotifier {
  List<FinancialRecord> _items = [];

  List<FinancialRecord> get all {
    return [..._items];
  }

  void setRegistros(List<FinancialRecord> registros){
    _items = registros;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get valorTotal {

    if(_items.isEmpty){
      return 0;
    }

    return _items.map((e) => e.value??=0).reduce((value, element) => value + element);
  }

  void salvarOuAtualizar(FinancialRecord record) {
    if (record == null) {
      return;
    }

    if(record.id == 0){
      DBProvider.db.insertFinancialRecord(record);
    }else{
      DBProvider.db.updateRegistroFinanceiro(record);
    }

    notifyListeners();
  }

  void put(FinancialRecord record) {
    print(record.toString());
    if (record == null || record.id == null) {
      return;
    }

    DBProvider.db.updateRegistroFinanceiro(record);

    notifyListeners();
  }

  FinancialRecord byIndex(int index) {
    return _items.elementAt(index);
  }

  void remove(FinancialRecord record){
    print(record.id);
    if(record != null && record.id != null){
      DBProvider.db.excluirRegistroFinanceiro(record.id??=0);
      notifyListeners();
    }

  }
}
