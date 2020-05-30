import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smusmu/func/func.dart';
import 'package:smusmu/locale/Translations.dart';
import 'package:smusmu/navigation/forum/create.dart';
import 'package:smusmu/navigation/forum/post.dart';

class Board extends StatefulWidget{
  final String boardType;
  const Board({Key key, this.boardType}) : super(key: key);
  _BoardState createState() => _BoardState(boardType);
}
class _BoardState extends State<Board>{
  final String boardType;

  _BoardState(this.boardType);
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

    return Scaffold(
        appBar: forumAppBar(locale(boardType, context)),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: ((){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>CreatePost(boardType: boardType,)));
          }),
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("BOARD")
                    .orderBy('REG_DATE', descending: true)
                    .snapshots(),
                builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return loading();
                  default:
                    return ListView(
                      children: snapshot.data.documents
                        .where((element) => element.data["BOARD_CODE"] == boardType ? true : false )
                        .map((DocumentSnapshot document){
                          return Card(
                            elevation: 2,
                            child: ListTile(
//                              leading: Text("temp"),
                              title: Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            document["POST_NAME"]
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(Icons.thumb_up),
                                              Icon(Icons.thumb_down)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: ((){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Post(
                                    boardType: boardType,
                                    postId: document['POST_ID'],
                                    writer: document['USER_ID'],
                                    documentId: document.documentID,
                                  )
                                ));
                              }),
                            )
                          );
                      }).toList()
                    );
                  }
                }
              )

        )
      );
  }
}

