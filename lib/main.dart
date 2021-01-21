import 'package:corona_app/coronaScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(CoronaApp());

class CoronaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Corona App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: CoronaScreen()
    );
  }
}
