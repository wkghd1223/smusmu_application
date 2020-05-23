import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class Translations {
  Translations(this.locale);
  final Locale locale;
  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }
  Map<String, String> _sentences;

  Future<bool> load() async {

    String data = await rootBundle.loadString('assets/locale/${locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value){
      this._sentences[key] = value.toString();
    });
    return true;
  }

  String trans (String key){
    return this._sentences[key];
  }
}
final nations = ['ko', 'en', 'vi','cn'];

class TranslationsDelegate extends LocalizationsDelegate<Translations> {


  const TranslationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return nations.contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    Translations localizations = new Translations(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;

}
String locale(String string,BuildContext context){
  return Translations.of(context).trans(string);
}