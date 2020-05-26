import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
enum Status{
  LOGOUT,
  LOGIN,
  COUNCIL
}
class Auth with ChangeNotifier , DiagnosticableTreeMixin {
  Status _status = Status.LOGOUT;
  Status get status {
    return _status;
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('status', status));
  }
}