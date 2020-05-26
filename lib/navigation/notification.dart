import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smusmu/func/item.dart';
import 'package:smusmu/locale/Translations.dart';


class Notifications extends StatefulWidget{
  _NotificationState createState() => _NotificationState();
}
class _NotificationState extends State<Notifications>{
  Item item = new Item();
  RefreshController _controller;
  final _children = <Widget>[];
  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {

    });

    _controller.refreshCompleted();
  }
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      print('df');
    });
    _controller.refreshCompleted();
  }

  @override
  initState() {
    // 부모의 initState호출
    super.initState();
    _controller = new RefreshController();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _children.clear();
    for(var i = 0; i < item.items.length; i++){
      _children.add(new ListTile(
        leading: Text(item.items[i]['title']),
        title: Text(item.items[i]['body']),
      ));
    }
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("smusmu"),
        ),
        body: SmartRefresher(
          child: ListView(
            children: _children,
          ),
          controller: _controller,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
        ),
      )

    );
  }
}