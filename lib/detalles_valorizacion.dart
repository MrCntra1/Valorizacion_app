import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'editar_valorizaciones.dart';
import 'valorizaciones.dart';

class DetalleValorizacion extends StatefulWidget {
  final Valorizacion valorizacion;

  const DetalleValorizacion({super.key, required this.valorizacion});

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

  Future<void> _downloadExcel() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      // Encabezados
      sheetObject.appendRow([
        'Número de Orden',
        'Nombre del Contratista',
        'Descripción del Servicio',
        'Fecha del Servicio',
        'Nombre del Servicio',
        'Monto del Contrato',
        'Cantidad Total m3',
        'Cantidad Restante m3'
      ]);

      // Datos
      sheetObject.appendRow([
        widget.valorizacion.numeroOrden,
        widget.valorizacion.nombreContratista,
        widget.valorizacion.descripcionServicio,
        widget.valorizacion.fechaServicio.toString(),
        widget.valorizacion.nombreServicio,
        widget.valorizacion.montoContrato.toString(),
        widget.valorizacion.cantidadTotal.toString(),
        widget.valorizacion.cantidadRestante.toString()
      ]);

      for (var entrega in widget.valorizacion.entregas) {
        sheetObject.appendRow([
          '',
          '',
          '',
          '',
          '',
          '',
          '${entrega.cantidad} m3 entregados',
          '${entrega.restante} restante',
          entrega.fecha.toString()
        ]);
      }

      final directory = await getExternalStorageDirectory();
      String filePath =
          '${directory?.path}/valorizacion_${widget.valorizacion.numeroOrden}.xlsx';
      var fileBytes = excel.save();
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo Excel descargado en $filePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
    }
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
