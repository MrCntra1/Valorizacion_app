import 'package:flutter/material.dart';
import 'valorizaciones.dart';

class DetalleValorizacion extends StatefulWidget {
  final Valorizacion valorizacion;

  DetalleValorizacion({required this.valorizacion});

  @override
  _DetalleValorizacionState createState() => _DetalleValorizacionState();
}

class _DetalleValorizacionState extends State<DetalleValorizacion> {
  final _cantidadController = TextEditingController();

  void _registrarEntrega() {
    if (_cantidadController.text.isNotEmpty) {
      final cantidad = double.parse(_cantidadController.text);
      setState(() {
        widget.valorizacion.registrarEntrega(cantidad);
      });
      _cantidadController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valorización'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Número de Orden', widget.valorizacion.numeroOrden),
            _buildDetailRow('Monto del Contrato', '\$${widget.valorizacion.montoContrato}'),
            _buildDetailRow('Nombre del Contratista', widget.valorizacion.nombreContratista),
            _buildDetailRow('Descripción del Servicio', widget.valorizacion.descripcionServicio),
            _buildDetailRow('Fecha del Servicio', widget.valorizacion.fechaServicio.toLocal().toString()),
            _buildDetailRow('Nombre del Servicio', widget.valorizacion.nombreServicio),
            _buildDetailRow('Condiciones de Pago', widget.valorizacion.condicionesPago),
            _buildDetailRow('Cantidad Total', '${widget.valorizacion.cantidadTotal} m3'),
            _buildDetailRow('Cantidad Restante', '${widget.valorizacion.cantidadRestante} m3'),
            SizedBox(height: 20),
            TextField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Registrar Entrega (m3)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: _registrarEntrega,
              child: Text('Registrar Entrega'),
            ),
            SizedBox(height: 20),
            Text('Entregas Realizadas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.valorizacion.entregas.length,
                itemBuilder: (context, index) {
                  final entrega = widget.valorizacion.entregas[index];
                  return ListTile(
                    title: Text('${entrega.cantidad} m3 entregados'),
                    subtitle: Text('Fecha: ${entrega.fecha.toLocal()}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
