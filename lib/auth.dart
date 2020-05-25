import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  bool _login = false;
  bool get getAuth => _login;

  void logIn(){
    _login=true;
    notifyListeners();
  }
  void logOut(){
    _login=false;
    notifyListeners();
  }
}