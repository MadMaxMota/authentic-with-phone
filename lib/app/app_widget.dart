import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth',
      theme: ThemeData(
        primaryColor: Colors.grey[200],
        accentColor: Color(0xff25D366),
      ),
      initialRoute: '/',
    ).modular();
  }
}
