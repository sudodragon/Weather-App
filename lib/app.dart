import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  static const title = 'Weather';

  final routes = {
    Home.routeName: (context) => Home(title: title,),
  };

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App.title,
      theme: ThemeData.light(),
      routes: routes,
    );
  }
}
