import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/locale/Translations.dart';

class CreatePost extends StatefulWidget{
  final String boardType;
  final bool isCreate;
  final String documentId;
  final String title;
  final String content;
  const CreatePost({Key key, this.boardType, this.isCreate, this.title, this.content, this.documentId}) : super(key: key);
  _CreatePostState createState() => _CreatePostState( boardType, isCreate, title, content, documentId);
}
class _CreatePostState extends State<CreatePost> {
  final String boardType;
  final bool isCreate;
  final String documentId;
  final String title;
  final String content;

  TextEditingController _textController;
  TextEditingController _titleController;

  String userId = 'wkghd1223';

  int numberOfDocument;
  _CreatePostState( this.boardType, this.isCreate, this.title, this.content, this.documentId);
  @override
  initState() {
    // 부모의 initState호출
    super.initState();
    countDocuments().then((num) {
      numberOfDocument= num+1;
    });
    _titleController = isCreate ? new TextEditingController() : new TextEditingController(text: title);
    _textController = isCreate ? new TextEditingController() : new TextEditingController(text: content);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(locale(boardType, context) + " > " + (isCreate ? locale("write", context) : locale("update", context)) ),
        backgroundColor: Colors.white,
      ),
      body: Container (
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child:
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                            fontSize: 30
                        ),
                        controller: _titleController,
                        onSubmitted: ((text){}),
                        decoration: new InputDecoration.collapsed(
                            hintText: locale("title", context),
                          )
                      ),
                    ),
                  ],
                )
              ),

              Card(
                elevation: 2,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        controller: _textController,
                        onSubmitted: _textFieldHandler,
                        decoration: new InputDecoration.collapsed(
                            hintText: locale("article_content", context)
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => _textFieldHandler(
                              _textController.text
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          )



      )
    );
  }
  void _textFieldHandler(String text){
    if(isCreate){
      Firestore.instance.collection('BOARD').add(
          {
            "BOARD_CODE": boardType,
            "POST_CONTENTS": text,
            "POST_LIKE":0,
            "POST_DISLIKE":0,
            "POST_NAME":_titleController.text,
            "POST_ID":numberOfDocument,
            "REG_DATE":Timestamp.now(),
            "USER_ID":userId
          }
      );
    }
    else {
      Firestore.instance
          .collection('BOARD')
          .document(documentId)
          .updateData({
        "POST_NAME":_titleController.text,
        "POST_CONTENTS": text,
        "UPDATE_DATE": Timestamp.now()
      });
    }

    
    _textController.clear();
    Navigator.pop(context);
  }
  Future<int> countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('BOARD').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length; // Count of Documents in Collection
  }
}