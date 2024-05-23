import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_config.dart';
import 'animacion.dart';  // Asegúrate de tener este import correctamente configurado
import 'creacion_valorizacion.dart';  // Asegúrate de tener este import correctamente configurado

void main() {
  runApp(inicio());
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalConfig()),
        // Agrega otros providers aquí si es necesario
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
