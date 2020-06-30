class Item {
  final String title;
  final String subtitle;

  Item({this.title, this.subtitle});

  Item.fromJson(Map<String, dynamic> json)
    : title = json['name'],
      subtitle = json['_id'];
}

class AppState {
  final List<Item> items;
  final bool isFetching;
  final Exception error;

  AppState({this.items, this.isFetching, this.error});

  AppState.initialState()
      : items = List.unmodifiable(<Item>[]),
        isFetching = false,
        error = null;
}