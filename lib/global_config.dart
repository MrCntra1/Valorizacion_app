// global_config.dart
import 'package:flutter/material.dart';

class GlobalConfig extends ChangeNotifier {
  double _multiplicador = 1.0;

  double get multiplicador => _multiplicador;

  void setMultiplicador(double value) {
    _multiplicador = value;
    notifyListeners();
  }
}

final globalConfig = GlobalConfig();
