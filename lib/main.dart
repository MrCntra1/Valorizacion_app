import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_config.dart';
import 'animacion.dart';
import 'creacion_valorizacion.dart';

void main() {
  runApp(inicio());
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalConfig()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Valorizaciones',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: animcion(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Nueva Valorización'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NuevaValorizacion()),
            );
          },
        ),
      ),
    );
  }
}
