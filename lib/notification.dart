import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/locale/Translations.dart';

class Notification extends StatefulWidget{
  _NotificationState createState() => _NotificationState();
}
class _NotificationState extends State<Notification>{
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