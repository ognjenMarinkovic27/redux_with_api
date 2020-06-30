import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_with_api/model/model.dart';
import 'redux/actions.dart';

class _ViewModel {
  final List<Item> items;
  final Function() onRefreshItems;

  final isFetching;

  _ViewModel({this.items, this.onRefreshItems, this.isFetching});

  factory _ViewModel.create(Store<AppState> store) {

    _onRefreshItems() {
      store.dispatch(FetchItemsAction());
    }

    return _ViewModel(
      items: store.state.items,
      onRefreshItems: _onRefreshItems,
      isFetching: store.state.isFetching
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ja sam pametan'),),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.create(store),
        builder: (context, viewModel) {
          return Column(
            children: <Widget>[
              viewModel.isFetching ?
              Expanded(
                child: ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (context, index) => ListTile(title: Text(viewModel.items[index].title!=null ? viewModel.items[index].title : "notext"), subtitle: Text(viewModel.items[index].subtitle!=null ? viewModel.items[index].subtitle : "notext"),)
                ),
              ) :
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    value: null,
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Refresh'),
                onPressed: () {
                  viewModel.onRefreshItems();
                },
              )
            ],
          );
        }
      )
    );
  }
}
