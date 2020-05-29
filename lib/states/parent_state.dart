import 'package:flutter/widgets.dart';
import 'package:parent_app/models/parent.dart';

class ParentState with ChangeNotifier {
  Parent _parent;

  ParentState.instance():_parent=Parent(0,'None',null,null,null,null,null,null,null);

  String get parentName => _parent.name;

  setParent(Parent parent) async {
    this._parent = parent;
    notifyListeners();
  }
}
