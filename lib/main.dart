
import 'package:flutter/material.dart';
import 'animacion.dart';


void main() {
  runApp(inicio());
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Valorizaciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    );
  }
}
