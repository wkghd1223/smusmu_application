import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

// ignore: non_constant_identifier_names
final FREE_BOARD = 'free_board';
// ignore: non_constant_identifier_names
final SECRET_BOARD = 'secret_board';

AppBar forumAppBar (String title){
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.white,
    elevation: 0.0,
  );
}
AppBar titleAppbar (){
  return AppBar(
    backgroundColor: Colors.white,

  );
}
Widget loading(){
  return Center(
    child: JumpingDotsProgressIndicator(
      fontSize: 50.0,
    ),
  );
}
Icon boardIcon (String board){
  if (board == FREE_BOARD)
    return Icon(Icons.people);
  else if (board == SECRET_BOARD)
    return Icon(Icons.person_outline);
  else
    return Icon(Icons.camera);
}

// Firestore CRUD Logic

//// 문서 생성 (Create)
//void createDoc(String name, String description) {
//  Firestore.instance.collection(colName).add({
//    fnName: name,
//    fnDescription: description,
//    fnDatetime: Timestamp.now(),
//  });
//}
//
//// 문서 조회 (Read)
//void showDocument(String documentID) {
//  Firestore.instance
//      .collection(colName)
//      .document(documentID)
//      .get()
//      .then((doc) {
//    showReadDocSnackBar(doc);
//  });
//}
//
//// 문서 갱신 (Update)
//void updateDoc(String docID, String name, String description) {
//  Firestore.instance.collection(colName).document(docID).updateData({
//    fnName: name,
//    fnDescription: description,
//  });
//}
//
//// 문서 삭제 (Delete)
//void deleteDoc(String docID) {
//  Firestore.instance.collection(colName).document(docID).delete();
//}
