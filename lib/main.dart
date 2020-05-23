import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locale/Translations.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: RaisedButton(
              child: Text(locale("hi",context)),
            ),
          ),
        ),
      );
  }
}
