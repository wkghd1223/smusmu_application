import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/locale/Translations.dart';

class Home extends StatefulWidget{
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
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
    return
      SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("smusmu"),),
          body: Center(
            child: Text("asdf"),
          )
      ),
    );
  }
}