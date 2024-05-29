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
      TextCellValue('Order Number'),
      TextCellValue('Total Quantity (m3)'),
      TextCellValue('Contract Amount'),
      TextCellValue('Contractor Name'),
      TextCellValue('Service Description'),
      TextCellValue('Service Date'),
      TextCellValue('Service Name')
    ]);

    // Add row for valorization
    sheetObject.appendRow([
      TextCellValue(valorization.orderNumber),
      DoubleCellValue(valorization.totalQuantity),
      DoubleCellValue(valorization.contractAmount),
      TextCellValue(valorization.contractorName),
      TextCellValue(valorization.serviceDescription),
      DateTimeCellValue.fromDateTime(valorization.serviceDate),
      TextCellValue(valorization.serviceName)
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
