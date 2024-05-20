class Entrega {
  final DateTime fecha;
  final double cantidad;

  Entrega({required this.fecha, required this.cantidad});
}

class Valorizacion {
  final String numeroOrden;
  final double montoContrato;
  final String nombreContratista;
  final String descripcionServicio;
  final DateTime fechaServicio;
  final String nombreServicio;
  final String condicionesPago;
  double cantidadTotal;
  double cantidadRestante;
  List<Entrega> entregas;

  Valorizacion({
    required this.numeroOrden,
    required this.montoContrato,
    required this.nombreContratista,
    required this.descripcionServicio,
    required this.fechaServicio,
    required this.nombreServicio,
    required this.condicionesPago,
    required this.cantidadTotal,
  }) : cantidadRestante = cantidadTotal,
       entregas = [];
  
  void registrarEntrega(double cantidad) {
    entregas.add(Entrega(fecha: DateTime.now(), cantidad: cantidad));
    cantidadRestante -= cantidad;
  }
}
