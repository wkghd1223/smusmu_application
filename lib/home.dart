import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/locale/Translations.dart';

class User{
  int _id;
  String _userName;
  User(int id, String userName){
    this._id = id;
    this._userName = userName;
  }
  String get id{ return _id.toString();}
  String get userName{ return _userName.toString();}
}
class Home extends StatefulWidget{
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
  List<User> users = List<User>();

  @override
  initState() {
    // 부모의 initState호출
    super.initState();

  }
  Future getData() async{

    print("asdf");
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("asdf");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("smusmu"),),
          body:Container(
            child: new ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index){
                return new Card(
                  child: ListTile(
                    leading: Text('${users[index].id}'),
                    title: Text('${users[index].userName}'),
                  ),
                );
              },
            )
        ),
      ),
    );
  }


}