class Item {
  static final Item _singleton = new Item._internal();
  List<Map<String, String>> _items;
  factory Item (){
    return _singleton;
  }

  Item._internal(){
    _items = List<Map<String,String>>();
  }
  void add(Map<String ,String> data){
    _items.add(data);
  }
  List<Map<String, String>> get items {
    return _items;
  }
}