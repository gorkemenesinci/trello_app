import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  final List<Map<String, String>> _list = [];
  String _visibility = "Herkese Açık";
  String _select = "";
  final List<Map<String, String>> _listTile = [];

  List<Map<String, String>> get list => _list;
  List<Map<String, String>> get listTile => _listTile;
  String get visibility => _visibility;
  String get select => _select;

  void addList(String title, String visibility) {
    _list.add({
      'title': title,
      'visibility': visibility,
    });
    notifyListeners();
  }

  void setVisibility(String visibility) {
    _visibility = visibility;
    notifyListeners();
  }

  void setSelect(String select) {
    _select = select;
    notifyListeners();
  }

  void addListTile(String title, String description, String dashboard) {
    _listTile.add(
        {'title': title, 'description': description, 'dashboard': dashboard});
  }
}
