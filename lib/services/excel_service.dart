import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/valorization.dart';

class ExcelService {
  Future<String> createExcel(Valorization valorization) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add column headers
    sheetObject.appendRow([
      "Order Number",
      "Total Quantity (m3)",
      "Contract Amount",
      "Contractor Name",
      "Service Description",
      "Service Date",
      "Service Name"
    ]);

    // Add row for valorization
    sheetObject.appendRow([
      valorization.orderNumber,
      valorization.totalQuantity,
      valorization.contractAmount,
      valorization.contractorName,
      valorization.serviceDescription,
      valorization.serviceDate.toIso8601String(),
      valorization.serviceName
    ]);

    // Save the file
    var directory = await getExternalStorageDirectory();
    var filePath = "${directory!.path}/valorization_${valorization.orderNumber}.xlsx";
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    return filePath;
  }
}
