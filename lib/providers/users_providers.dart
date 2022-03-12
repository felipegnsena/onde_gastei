import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class UsersProvider with ChangeNotifier {
  Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        !user.id.trim().isEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
          user.id, (_) => User(user.id, user.name, user.email, user.avatarUrl));
    } else {
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(id, () => User(id, user.name, user.email, ''));
    }

    //atualiza interface
    notifyListeners();
  }

  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      //atualiza interface
      notifyListeners();
    }

  }
}
