import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'func/auth.dart';
import 'package:smusmu/func/item.dart';
import 'locale/Translations.dart';
import 'nav.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> Auth(),
        )
      ],
      child :MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMUSMU',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SMUSMU'),
      supportedLocales : [
        const Locale('en', 'US'),
        const Locale('ko', 'KR'),
        const Locale('vi', 'VI'),
        const Locale('cn', 'CN'),
      ],
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!");
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");
            return supportedLocale;
          }
        }
        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Item items = new Item();
  var next = MaterialPageRoute(builder: (context) => Nav());
  void firebaseCloudMessagingListeners(){
    if(Platform.isIOS) iOSPermission();
    _firebaseMessaging.getToken().then((token) => {
      print('token | $token')
    });
    _firebaseMessaging.configure(
      // fires when the app is open and running in the foreground.
      onMessage: (Map<String, dynamic> message) async {
        Map<String, String> temp = {
          'title' : message['notification']['title'],
          'body'  : message['notification']['body']
        };
        items.add(temp);
        if(items.items.isNotEmpty){
          for(var i = 0; i < items.items.length; i++)
            print(items.items[i]['title']);
        }
        print('on message $message');
      },
      // fires if the app is closed, but still running in the background.
      onResume: (Map<String, dynamic> message) async {
        Map<String, String> temp = {
          'title' : message['notification']['title'],
          'body'  : message['notification']['body']
        };
        items.add(temp);
        print('on resume $message');
      },
      // fires if the app is fully terminated.
      onLaunch: (Map<String, dynamic> message) async {
        Map<String, String> temp = {
          'title' : message['notification']['title'],
          'body'  : message['notification']['body']
        };
        items.add(temp);
        print('on launch $message');
      },
    );
  }
  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessagingListeners();
    Future.delayed(Duration(seconds: 1),()=>{
      Navigator.pushReplacement(context, next)
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color : Colors.orangeAccent,
            image: DecorationImage(
              image: Image.asset('assets/images/logo.png').image,
//          fit: BoxFit.cover,
            )
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child:Text("version : 0.0.1",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),

        ),
      );

  }
}
