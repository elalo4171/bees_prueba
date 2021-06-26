import 'package:bees_prueba/tools/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bees',
      initialRoute: "home",
      onGenerateRoute: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
