import 'package:cloud_firestore/cloud_firestore.dart';
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
      Scaffold(
        appBar: forumAppBar(locale("forum", context)),
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child:
                StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("BOARD_LIST").snapshots(),
                builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                return loading();
                default:
                return ListView(
                  children: snapshot.data.documents
                  .map((DocumentSnapshot document){
                    return ListTile(
                      leading: boardIcon(document['BOARD_CODE']),
                      title: Text(locale(document['BOARD_CODE'], context)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Board(
                          boardType:document['BOARD_CODE']
                        )));
                      },
                    );
                  }).toList(),
                );
                }})

              ),
            )
        );
  }
}