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
    var threeDotMenuWriter = {"delete"};
    var threeDotMenuNotWriter = {"send_message"};
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
                                .where((element) => element.data['POST_ID'] == postId)
                                .map((DocumentSnapshot document) {
                              var reply = [];
                              reply = document['POST_REPLY'] ?? [];
                              List<Widget> empty = [];
                              return Container(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              /// 글 제목 시작
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(document['POST_NAME'],
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                      ))
                                              ),
                                              /// 글 제목 종료
                                              SizedBox(width: 10,),
                                              /// 유저 아이디 시작
                                              Text(document['USER_ID'])
                                              /// 유저 아이디 종료
                                            ],
                                          ),

                                          /// 삭제 혹은 메세지 보내기 시작
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: PopupMenuButton<String>(
                                              icon: Icon(Icons.more_horiz),
                                              onSelected: _threeDotMenuHandler,
                                              itemBuilder: (BuildContext context){
                                                return (document['USER_ID'] == userId ? threeDotMenuWriter : threeDotMenuNotWriter).map((String choice) {
                                                  return PopupMenuItem<String>(
                                                    value: choice,
                                                    child: Text(locale(choice, context)),
                                                  );
                                                }).toList();
                                              },
                                            )
                                          )
                                          /// 삭제 혹은 메세지 보내기 종료
                                        ],
                                      ),

                                      SizedBox(height: 20,),

                                      /// 글 내용 시작
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(document['POST_CONTENTS']) ,
                                      ),
                                      /// 글 내용 종료

                                      SizedBox(height: 20,),

                                      /// 댓글 입력 시작
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
                                                        hintText: locale("comment_me", context)
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
                                      /// 댓글 입력 종료

                                      SizedBox(height: 20,),

                                      /// 댓글 시작 ///
                                      Column(
                                        children: reply.length ==0 ? empty : reply.asMap().map((i, element){
                                          return MapEntry(i, InkWell(
                                            onLongPress: (){
                                              showDeleteReplyDialog(i);
                                            },
                                            child: ListTile(
                                              leading:Text(element['USER_ID']),
                                              title: Text(element['REPLY_CONTENTS']),
                                              trailing: Column(
                                                children: [
                                                  Icon(Icons.thumb_up),
                                                  Icon(Icons.thumb_down)
                                                ],
                                              ),
                                            ),
                                          ));
                                        }).values.toList()
                                      )
                                      /// 댓글 종료 ///
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

  /// 댓글 입력 핸들러 시작
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
  /// 댓글 입력 핸들러 종료
  /// 3점 메뉴 핸들러 시작
  void _threeDotMenuHandler(String value){
    switch (value) {
      case 'delete':
      showDeleteDocDialog();
        break;
      case 'send_message':
        break;
    }
  }
  /// 3점 메뉴 핸들러 종료
  /// 글 삭제 다이얼로그 시작
  void showDeleteDocDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(locale("real_delete", context)),
          actions: <Widget>[
            FlatButton(
              child: Text(locale("cancel", context)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(locale("delete", context),
              style: TextStyle(
                color: Colors.red
              ),),
              onPressed: () {
                var count = 0;
                /// 문서 삭제
                Firestore.instance.collection('BOARD').document(documentId).delete();
                /// 2번 pop
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            )
          ],
        );
      });
  }
  /// 글 삭제 다이얼로그 종료
  /// 댓글 삭제 다이얼로그 시작
  void showDeleteReplyDialog(int index){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(locale("real_delete", context)),
            actions: <Widget>[
              FlatButton(
                child: Text(locale("cancel", context)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(locale("delete", context),
                  style: TextStyle(
                      color: Colors.red
                  ),),
                onPressed: () {
                  /// 댓글 삭제
//                  Firestore.instance.collection('BOARD')
//                      .document(documentId)
//                      .updateData({"POST_REPLY" : FieldValue.arrayRemove()});
                  //  {"POST_REPLY": FieldValue.arrayUnion(obj)};
                  /// 1번 pop
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  /// 댓글 삭제 다이얼로그 종료
  ///
  Future<int> countReplies() async {
    var replies = [];
    await Firestore.instance.collection('BOARD')
        .document(documentId)
        .get()
        .then((value) {
          replies = value['POST_REPLY'];
    });
    return replies.length; // Count of Replies
  }
}
