class Entrega {
  final DateTime fecha;
  final double cantidad;

  Entrega({required this.fecha, required this.cantidad});
}

class Valorizacion {
  String numeroOrden;
  double montoContrato;
  String nombreContratista;
  String descripcionServicio;
  DateTime fechaServicio;
  String nombreServicio;
  String condicionesPago;
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

  void actualizar({
    String? numeroOrden,
    double? montoContrato,
    String? nombreContratista,
    String? descripcionServicio,
    DateTime? fechaServicio,
    String? nombreServicio,
    String? condicionesPago,
    double? cantidadTotal,
  }) {
    if (numeroOrden != null) this.numeroOrden = numeroOrden;
    if (montoContrato != null) this.montoContrato = montoContrato;
    if (nombreContratista != null) this.nombreContratista = nombreContratista;
    if (descripcionServicio != null) this.descripcionServicio = descripcionServicio;
    if (fechaServicio != null) this.fechaServicio = fechaServicio;
    if (nombreServicio != null) this.nombreServicio = nombreServicio;
    if (condicionesPago != null) this.condicionesPago = condicionesPago;
    if (cantidadTotal != null) this.cantidadTotal = cantidadTotal;
  }
}

