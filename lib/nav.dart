import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smusmu/locale/Translations.dart';

import 'home.dart';

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
class Nav extends StatefulWidget{
  _NavState createState() => _NavState();
}
class _NavState extends State<Nav>{
  List<User> users = List<User>();
  int _currentIndex =0;
  final List<Widget> _children = [Home(),Home(),Home()];
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
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index)=>{
          setState(()=>{
          _currentIndex = index
          })
        },
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(locale("home", context))
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.airplay),
                title: Text(locale("forum", context))
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text(locale("notification", context))
            ),
          ],
        ),
      ),
    );
  }


}