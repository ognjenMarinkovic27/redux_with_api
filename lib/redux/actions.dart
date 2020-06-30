import 'package:redux_with_api/model/model.dart';

class FetchItemsAction {}

class FetchItemsSucceededAction {
  final List<Item> fetchedItems;

  FetchItemsSucceededAction(this.fetchedItems);
}

class FetchItemsFailedAction {
  final Exception error;

  FetchItemsFailedAction(this.error);
}