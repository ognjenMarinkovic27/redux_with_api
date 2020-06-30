import 'dart:convert';

import 'actions.dart';
import 'package:redux_with_api/model/model.dart';

import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

Future<List<Item>> fetchItems() async {
  final response = await http.get("https://lutalica.herokuapp.com/api/clubs");

  if(response.statusCode == 200) {
    return List<Item>.from(jsonDecode(response.body).map((map) => Item.fromJson(map)).toList());
  }
  else {
    print('Error');
    return [];
  }
}

void fetchItemsMiddleware(Store<AppState> store, action, NextDispatcher next) async {

  print(action.toString() + ' in fetchItemsMiddleware');
  if(action is FetchItemsAction) {
    await fetchItems().then((List<Item> items) => store.dispatch(FetchItemsSucceededAction(items))).catchError((Object error) => store.dispatch(FetchItemsFailedAction(error)));
  }

  next(action);
}