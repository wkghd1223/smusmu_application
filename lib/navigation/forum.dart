import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/func/func.dart';
import 'package:smusmu/locale/Translations.dart';
import 'package:smusmu/navigation/forum/board.dart';

class Forum extends StatefulWidget{
  _ForumState createState() => _ForumState();
}
class _ForumState extends State<Forum>{
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
          appBar: forumAppBar(locale("forum", context)),
            body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text(locale("free_board", context)),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Board()));
                    },
                  )
                ],
              ),
            )
        ),
      );
  }
}