import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/func/func.dart';
import 'package:smusmu/locale/Translations.dart';
import 'package:smusmu/navigation/forum/board.dart';

class Post extends StatefulWidget{
  final String writer;
  final String boardType;
  final int postId;
  final String documentId;

  const Post({Key key, this.writer, this.boardType, this.postId, this.documentId}) : super(key: key);
  _PostState createState() => _PostState(writer, boardType, postId,documentId);
}
class _PostState extends State<Post> {
  final String writer;
  final String boardType;
  final int postId;
  final String documentId;
  final TextEditingController _textController = new TextEditingController();

  String userId= 'wkghd1223';
  _PostState(this.writer, this.boardType, this.postId, this.documentId);

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
          appBar: titleAppbar(),
          body: SafeArea(
            child: Container(
                color: Colors.white,
                child:
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("BOARD").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text("Error: ${snapshot.error}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return loading();
                        default:
                          return ListView(
                            children: snapshot.data.documents
                                .where((element) =>
                            element.data['POST_ID'] == postId)
                                .map((DocumentSnapshot document) {
                              var reply = [];
                              reply = document['POST_REPLY'] ?? [];
                              List<Widget> empty = [];
                              return Container(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(document['POST_NAME'],
                                              style: TextStyle(
                                                fontSize: 30,
                                              ))
                                      ),
                                      SizedBox(height: 20,),

                                      Text(document['POST_CONTENTS']),

                                      SizedBox(height: 20,),

                                      Container(
                                        child: Card(
                                            elevation: 2,
                                            child:
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: TextField(
                                                    controller: _textController,
                                                    onSubmitted: _handleSubmitted,
                                                    decoration: new InputDecoration
                                                        .collapsed(
                                                        hintText: "댓글 입력해라"
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: IconButton(
                                                    icon: Icon(Icons.send),
                                                    onPressed: () =>
                                                        _handleSubmitted(
                                                            _textController
                                                                .text),
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                      ),

                                      SizedBox(height: 20,),

                                      // 댓글
                                      Column(
                                        children: reply.length ==0 ? empty : reply.asMap().map((i, element){
                                          return MapEntry(i, ListTile(

                                            leading:Text(element['USER_ID']),
                                            title: Text(element['REPLY_CONTENTS']),
                                            trailing: Column(
                                              children: [
                                                Icon(Icons.thumb_up),
                                                Icon(Icons.thumb_down)
                                              ],
                                            ),
                                          ));
                                        }).values.toList()
                                      )
                                    ],
                                  )
                              );
                            }).toList(),
                          );
                      }
                    })

            ),
          )
      );
  }

  void _handleSubmitted(String text) {
    var obj = [{
      "REPLY_CONTENTS" : text,
      "REPLY_LIKES":0,
      "REPLY_DISLIKES":0,
      "REPLY_TIME":Timestamp.now(),
      "USER_ID":userId
    }];
    Firestore.instance.collection('BOARD').document(documentId).updateData({"POST_REPLY": FieldValue.arrayUnion(obj)});
    _textController.clear();
  }
}