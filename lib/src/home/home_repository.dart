import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';

class HomeRepository {


  Future<List<Item>> getItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? itemListString = sharedPreferences.getStringList('items');
    if (itemListString != null) {
      List<Item> items = itemListString
          .map<Item>((item) => Item.fromJson(jsonDecode(item)))
          .toList();
      return items;
    } else {
      throw Exception();
    }
  }

  Future<void> saveItem(List<Item> items) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> itemListString =
    items.map((item) => jsonEncode(item.toJson())).toList();
    await sharedPreferences.setStringList('items', itemListString);
  }

}
