import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smusmu/auth.dart';
import 'package:smusmu/locale/Translations.dart';

class Home extends StatefulWidget{
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
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
    final auth = Provider.of<Auth>(context);
    return
      SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                RaisedButton(
                  child: Text("login"),
                  onPressed: (){
                    context.read<Auth>().logIn();
//                    auth.logIn();
                  },
                ),
                RaisedButton(
                  child: Text("logout"),
                  onPressed: (){
                    auth.logOut();
                  },
                ),
                RaisedButton(
                  child: Text("council"),
                  onPressed: (){
                    context.read<Auth>().makeCouncil();
//                    auth.logIn();
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}