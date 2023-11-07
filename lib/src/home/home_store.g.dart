// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$itemsAtom = Atom(name: '_HomeStore.items', context: context);

  @override
  List<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$addItemAsyncAction =
      AsyncAction('_HomeStore.addItem', context: context);

  @override
  Future addItem(String text) {
    return _$addItemAsyncAction.run(() => super.addItem(text));
  }

  late final _$editItemAsyncAction =
      AsyncAction('_HomeStore.editItem', context: context);

  @override
  Future editItem(int index, String description) {
    return _$editItemAsyncAction.run(() => super.editItem(index, description));
  }

  late final _$removeItemAsyncAction =
      AsyncAction('_HomeStore.removeItem', context: context);

  @override
  Future removeItem(int index) {
    return _$removeItemAsyncAction.run(() => super.removeItem(index));
  }

  @override
  String toString() {
    return '''
items: ${items}
    ''';
  }
}
