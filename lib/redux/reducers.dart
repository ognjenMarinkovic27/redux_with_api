import 'package:redux_with_api/model/model.dart';
import 'actions.dart';

AppState appReducer(AppState state, action) {
  print(action.toString()+' in appReducer');
  if(action is FetchItemsAction) {
    print('isFetching true');
    return AppState(
      items: itemReducer(state.items, action),
      isFetching: true,
      error: null
    );
  }
  else if(action is FetchItemsSucceededAction) {
    print('isFetching false');
    return AppState(
      items: itemReducer(state.items, action),
      isFetching: false,
      error: null
    );
  }
  else if(action is FetchItemsFailedAction) {
    print('isFetching false');
    return AppState(
      items: itemReducer(state.items, action),
      isFetching: false,
      error: action.error
    );
  }

  return AppState(
    items: itemReducer(state.items, action)
  );
}

List<Item> itemReducer (List<Item> state, action) {
  if(action is FetchItemsSucceededAction) {
    return action.fetchedItems;
  }
  return state;
}