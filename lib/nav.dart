import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/forum.dart';
import 'package:smusmu/locale/Translations.dart';
import 'navigation/user.dart';
import 'func/auth.dart';
import 'navigation/home.dart';
import 'navigation/notification.dart';

class Nav extends StatefulWidget{
  _NavState createState() => _NavState();
}
class _NavState extends State<Nav>{
  BottomNavigationBadge badger = new BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8);
  int _currentIndex =0;
  final List<Widget> _children = [Home(), Forum(), Notifications(),User()];
  List<BottomNavigationBarItem> _navs = List<BottomNavigationBarItem>();
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
    if(_navs.isEmpty) {
      _navs = [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(locale("home", context))
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.airplay),
            title: Text(locale("forum", context))
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(locale("notification", context))
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text(locale("user", context))
        ),
      ];
      _navs = badger.setBadge(_navs, "1", 2);
      print("initialize Bottom Nav...");
    }
    return Scaffold(
              body: _children[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index)=>{
                  setState((){
                    _currentIndex = index;
                    print("Bottom Nav Index | $index");
                    if(index == 2){
                      _navs = badger.removeBadge(_navs, 2);
                    }
                  })
                },
                currentIndex: _currentIndex,
                items: _navs,
              ),
            );
  }
}