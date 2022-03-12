import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_finantial_records.dart';
import 'package:flutter_crud/models/financial_record.dart';

class FinancialRecordProvider with ChangeNotifier {
  Map<int, FinancialRecord> _items = {...DUMMY_FINANTIAL_RECORDS};

  List<FinancialRecord> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  void put(FinancialRecord record) {
    if (record == null) {
      return;
    }

    if (record.id != null &&
        _items.containsKey(record.id)) {
      _items.update(
          record.id??=0, (_) => new FinancialRecord(record.id??=0, record.value, record.descricao));
    } else {
      final id = count+1;

      _items.putIfAbsent(id, () => new FinancialRecord(id, record.value, record.descricao));

    }

    //atualiza interface
    notifyListeners();
  }

  FinancialRecord byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void remove(FinancialRecord record){
    print(record.id);
    if(record != null && record.id != null){
      _items.remove(record.id);
      _items.forEach((key, value) {print(key);});
      //atualiza interface
      notifyListeners();
    }

  }
}
