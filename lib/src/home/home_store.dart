import 'package:login/src/home/home_repository.dart';
import 'package:mobx/mobx.dart';

import '../models/item.dart';

part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {

  HomeRepository homeRepository = HomeRepository();

  @observable
  List<Item> items = [];

  _HomeStore() {
    get();
  }

  @action
  addItem(String text) async {
    items.add(Item(description: text));
    saveRepository();
  }

  @action
  editItem(int index, String description) async {
    Item item = items.elementAt(index);
    item.description = description;
    saveRepository();
  }

  @action
  removeItem(int index) async {
    items.removeAt(index);
    saveRepository();
  }


  void saveRepository() async {
    await homeRepository.saveItem(items);
    get();
  }

  void get() async {
    List<Item> itemList = await  homeRepository.getItems();
    items = itemList;
    }

}
