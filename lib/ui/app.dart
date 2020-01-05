import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/state.dart';
import '../store/store.dart';
import 'login_page.dart';
import 'menu_page.dart';
import 'color.dart';
import 'keys.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          accentColor: AppColor.red,
          primaryColor: AppColor.red,
        ),
        navigatorKey: Keys.navigationKey,
        home: LoginPage(),
        routes: {
          'loginPage': (context) => LoginPage(),
          'menuPage': (context) => MenuPage()
        },
      ),
    );
  }
}
