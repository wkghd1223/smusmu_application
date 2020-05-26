import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smusmu/locale/Translations.dart';

import '../func/auth.dart';

Widget userWithAuth(BuildContext context){
  String a = '일반학생';
  String b = '학생회';
  return Center(
    child: Text("login\n${ context.watch<Auth>().status == Status.COUNCIL ? b : a}"),
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
    return context.watch<Auth>().status  != Status.LOGOUT ? userWithAuth(context) : userWithoutAuth();
  }
}