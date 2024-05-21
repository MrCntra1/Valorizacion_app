import 'package:flutter/material.dart';
import 'pantalla_principal.dart';

void main() {
  runApp(inicio());
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorizaciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
