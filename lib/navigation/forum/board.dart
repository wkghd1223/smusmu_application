import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smusmu/func/func.dart';
import 'package:smusmu/locale/Translations.dart';

class Board extends StatefulWidget{
  _BoardState createState() => _BoardState();
}
class _BoardState extends State<Board>{
  RefreshController _controller;
  final _children = <Widget>[];
  
  Future<void> _onRefresh() async{
    print('refreshing article...');

    setState(() {
    });

    _controller.refreshCompleted();
  }
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
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

    return SafeArea(
        child: Scaffold(
            appBar: forumAppBar(locale("free_board", context)),
            body: SmartRefresher(
              child: ListView(
                children: <Widget>[
                    ListTile(
                      title: Text("${locale("title", context)}${_children.length}"),
                      subtitle: Text(locale("main_text", context)),
                      trailing: Container(
                        child: Column(
                        children: [

                          Icon(Icons.thumb_up),
                          Icon(Icons.thumb_down)

                        ],
                      ),
                    ),
                    )
                ]
              ),
              controller: _controller,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
            ),

        )
      );
  }
}