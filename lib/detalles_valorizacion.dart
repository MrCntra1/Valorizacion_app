import 'package:flutter/material.dart';
import 'detalle_valorizacion_widget.dart';
import 'valorizaciones.dart';

class DetallesValorizacionPage extends StatelessWidget {
  final Valorizacion valorizacion;

  const DetallesValorizacionPage({Key? key, required this.valorizacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Valorización'),
        backgroundColor: Colors.blue,
      ),
      body: DetalleValorizacion(valorizacion: valorizacion),
    );
  }
}
