import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/valorization.dart';

class ExcelService {
  Future<void> createAndDownloadExcel(List<Valorization> valorizations) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Añadir encabezados de columna
    sheetObject.appendRow([
      "Order Number",
      "Total Quantity (m3)",
      "Contract Amount",
      "Contractor Name",
      "Service Description",
      "Service Date",
      "Service Name"
    ]);

    // Añadir filas para cada valorización
    for (var valorization in valorizations) {
      sheetObject.appendRow([
        valorization.orderNumber,
        valorization.totalQuantity,
        valorization.contractAmount,
        valorization.contractorName,
        valorization.serviceDescription,
        valorization.serviceDate.toIso8601String(),
        valorization.serviceName
      ]);
    }

    // Guardar el archivo
    var directory = await getExternalStorageDirectory();
    var filePath = "${directory!.path}/valorization.xlsx";
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    // Lógica adicional para manejar la descarga si es necesario
  }
}
