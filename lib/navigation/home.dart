import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smusmu/func/auth.dart';
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
    return
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(locale("title", context)),
          ),
          body: Center(
            child: Column(
              children: [
                RaisedButton(
                  child: Text("login"),
                  onPressed: (){
                    context.read<Auth>().logIn();
                  },
                ),
                RaisedButton(
                  child: Text("logout"),
                  onPressed: (){
                    context.read<Auth>().logOut();
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