import 'package:flutter/material.dart';
import 'excel_manager.dart';
import 'editar_valorizaciones.dart';
import 'valorizaciones.dart';

class DetalleValorizacion extends StatefulWidget {
  final Valorizacion valorizacion;

  const DetalleValorizacion({Key? key, required this.valorizacion})
      : super(key: key);

  @override
  _DetalleValorizacionState createState() => _DetalleValorizacionState();
}

class _DetalleValorizacionState extends State<DetalleValorizacion> {
  final _cantidadController = TextEditingController();

  void _registrarEntrega() {
    if (_cantidadController.text.isEmpty) {
      return;
    }

    final cantidad = double.tryParse(_cantidadController.text);
    if (cantidad == null ||
        cantidad <= 0 ||
        cantidad > widget.valorizacion.cantidadRestante) {
      return;
    }

    setState(() {
      widget.valorizacion.registrarEntrega(cantidad);
    });

    _cantidadController.clear();
  }

  void _editarValorizacion() async {
    final resultado = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditarValorizacionScreen(valorizacion: widget.valorizacion),
      ),
    );

    if (resultado != null) {
      setState(() {
        widget.valorizacion.actualizar(
          numeroOrden: resultado.numeroOrden,
          montoContrato: resultado.montoContrato,
          nombreContratista: resultado.nombreContratista,
          descripcionServicio: resultado.descripcionServicio,
          fechaServicio: resultado.fechaServicio,
          nombreServicio: resultado.nombreServicio,
          cantidadTotal: resultado.cantidadTotal,
        );
      });
    }
  }

  Future<void> _downloadExcel() {
    return ExcelManager().downloadExcel(widget.valorizacion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valorización'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editarValorizacion,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadExcel,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            _buildDetailRow(
                'Número de Orden:', widget.valorizacion.numeroOrden),
            _buildDetailRow('Nombre del Contratista:',
                widget.valorizacion.nombreContratista),
            _buildDetailRow('Descripción del Servicio:',
                widget.valorizacion.descripcionServicio),
            _buildDetailRow('Fecha del Servicio:',
                widget.valorizacion.fechaServicio.toString()),
            _buildDetailRow(
                'Nombre del Servicio:', widget.valorizacion.nombreServicio),
            _buildDetailRow('Monto del Contrato:',
                '\$${widget.valorizacion.montoContrato}'),
            _buildDetailRow('Cantidad Total m3:',
                '${widget.valorizacion.cantidadTotal} m3'),
            _buildDetailRow('Cantidad Restante m3:',
                '${widget.valorizacion.cantidadRestante} m3'),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: widget.valorizacion.cantidadRestante > 0
                  ? _registrarEntrega
                  : null,
              child: const Text(
                'Registrar Entrega',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Entregas Realizadas:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...widget.valorizacion.entregas.map((entrega) {
              return ListTile(
                title: Text('${entrega.cantidad} m3 entregados'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cantidad restante ${entrega.restante}'),
                    Text('Fecha ${entrega.fecha}'),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}