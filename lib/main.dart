import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_with_api/model/model.dart';
import 'package:redux_with_api/redux/actions.dart';
import 'package:redux_with_api/redux/middleware.dart';
import 'package:redux_with_api/redux/reducers.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Store<AppState> store = new Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: [fetchItemsMiddleware],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StoreBuilder<AppState>(
          onInit: (Store<AppState> store) => store.dispatch(FetchItemsAction()),
          builder: (BuildContext context, Store<AppState> store) => Home(),
        ),
      ),
    );
  }
}