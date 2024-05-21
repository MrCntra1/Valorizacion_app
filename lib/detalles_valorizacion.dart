import 'package:flutter/material.dart';
import 'editar_vlorizaciones.dart';
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
    if (_cantidadController.text.isEmpty) {
      return;
    }

    final cantidad = double.tryParse(_cantidadController.text);
    if (cantidad == null ||
        cantidad <= 0 ||
        cantidad > widget.valorizacion.cantidadRestante) {
      // Mostrar un error si la cantidad no es válida
      return;
    }

    setState(() {
      widget.valorizacion.registrarEntrega(cantidad);
    });

    _cantidadController.clear();
  }

  void _editarValorizacion() async {
    // Implementar la navegación a la pantalla de edición y actualizar los datos
    final resultado = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditarValorizacionScreen(valorizacion: widget.valorizacion),
      ),
    );

    if (resultado != null) {
      setState(() {
        // Actualizar la valorización con los datos editados
        widget.valorizacion.actualizar(
          numeroOrden: resultado.numeroOrden,
          montoContrato: resultado.montoContrato,
          nombreContratista: resultado.nombreContratista,
          descripcionServicio: resultado.descripcionServicio,
          fechaServicio: resultado.fechaServicio,
          nombreServicio: resultado.nombreServicio,
          condicionesPago: resultado.condicionesPago,
          cantidadTotal: resultado.cantidadTotal,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valorización'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editarValorizacion,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Implementar la lógica de descarga aquí
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
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
            _buildDetailRow(
                'Cantidad Total:', '${widget.valorizacion.cantidadTotal} m3'),
            _buildDetailRow('Cantidad Restante:',
                '${widget.valorizacion.cantidadRestante} m3'),
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
              onPressed: widget.valorizacion.cantidadRestante > 0
                  ? _registrarEntrega
                  : null,
              child: Text(
                'Registrar Entrega',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Entregas Realizadas:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...widget.valorizacion.entregas.map((entrega) {
              return ListTile(
                title: Text('${entrega.cantidad} m3 entregados'),
                subtitle: Text('Fecha: ${entrega.fecha.toString()}'),
              );
            }).toList(),
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
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
