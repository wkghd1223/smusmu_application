import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smusmu/locale/Translations.dart';

import 'auth.dart';

Widget userWithAuth(){
  return Center(
    child: Text("login"),
  );
}
Widget userWithoutAuth(){
  return Center(
    child: Text("logout"),
  );
}
class User extends StatefulWidget{
  _UserState createState() => _UserState();
}
class _UserState extends State<User>{
  @override
  initState() {
    // 부모의 initState호출
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.getAuth ? userWithAuth() : userWithoutAuth();
  }
}