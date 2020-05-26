import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
enum Status{
  LOGOUT,
  LOGIN,
  COUNCIL
}
class Auth with ChangeNotifier , DiagnosticableTreeMixin{
  Status _status = Status.LOGOUT;
  int get status {
    return _status == Status.LOGOUT ? 0 : _status == Status.LOGIN ? 1 : 2;
  }
  void logIn(){
    _status=Status.LOGIN;
    notifyListeners();
  }
  void logOut(){
    _status=Status.LOGOUT;
    notifyListeners();
  }
  void makeCouncil(){
    _status = Status.COUNCIL;
    notifyListeners();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
    properties.add(IntProperty('status',status));
  }
}