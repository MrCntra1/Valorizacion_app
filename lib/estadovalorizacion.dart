import 'package:flutter/material.dart';
import 'valorizaciones.dart';

class ValorizacionProvider with ChangeNotifier {
  List<Valorizacion> _valorizaciones = [];

  List<Valorizacion> get valorizaciones => _valorizaciones;

  void addValorizacion(Valorizacion valorizacion) {
    _valorizaciones.add(valorizacion);
    notifyListeners();
  }
}
