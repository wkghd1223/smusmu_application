import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'locale/Translations.dart';
import 'nav.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  var next = MaterialPageRoute(builder: (context) => Nav());
  void firebaseCloudMessagingListeners(){
    if(Platform.isIOS) iOSPermission();
    _firebaseMessaging.getToken().then((token) => {
      print('token | $token')
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
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
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color : Colors.orangeAccent,
        image: DecorationImage(
          image: Image.asset('assets/images/logo.png').image,
//          fit: BoxFit.cover,
        )
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              child: Text(locale('hi', context)),
              onPressed: (){
                Navigator.pushReplacement(context, next);
              },
            ),
            Text(
              "version : 0.0.1",
              style: TextStyle(
                fontSize: 30
              ),
            ),
          ],
        ) 

      ),
    );
  }
}
