import 'package:flutter/material.dart';

import './homepage.dart';

void main() => runApp(Homepage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData.dark(),
      home: Calculator(),
    );
  }
}
