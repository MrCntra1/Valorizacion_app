import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'valorizaciones.dart';

class ExcelManager {
  Future<void> downloadExcel(Valorizacion valorizacion) async {
    await _requestPermission();

    var status = await Permission.storage.status;
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
        valorizacion.numeroOrden,
        valorizacion.nombreContratista,
        valorizacion.descripcionServicio,
        valorizacion.fechaServicio.toString(),
        valorizacion.nombreServicio,
        valorizacion.montoContrato.toString(),
        valorizacion.cantidadTotal.toString(),
        valorizacion.cantidadRestante.toString()
      ]);

      for (var entrega in valorizacion.entregas) {
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
          '${directory?.path}/valorizacion_${valorizacion.numeroOrden}.xlsx';
      var fileBytes = excel.save();
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      // Muestra una notificación cuando se completa la descarga
      // Esta parte no la implementé en el widget original, pero es fácilmente adaptable
      // si deseas agregar una notificación similar en el widget
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Archivo Excel descargado en $filePath')),
      // );
    } else {
      // Manejo de caso en el que se deniegan los permisos
      // Esta parte no la implementé en el widget original, pero es adaptable
      // si deseas mostrar una notificación cuando se deniegan los permisos
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Permiso de almacenamiento denegado')),
      // );
    }
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}
