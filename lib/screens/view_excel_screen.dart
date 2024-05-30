import 'package:flutter/material.dart';
import '../models/valorization.dart';
import '../services/excel_service.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Importa la biblioteca path_provider

class ViewExcelScreen extends StatefulWidget {
  final Valorization valorization;

  const ViewExcelScreen({Key? key, required this.valorization})
      : super(key: key);

  @override
  _ViewExcelScreenState createState() => _ViewExcelScreenState();
}

class _ViewExcelScreenState extends State<ViewExcelScreen> {
  bool _isLoading = true;
  String? _filePath;
  List<List<String>> _excelData = [];

  @override
  void initState() {
    super.initState();
    _convertToExcel();
  }

  Future<void> _convertToExcel() async {
    final excelService = ExcelService();
    final filePath = await excelService.createExcel(widget.valorization);
    setState(() {
      _filePath = filePath;
    });
    _readExcel();
  }

  Future<void> _readExcel() async {
    var bytes = File(_filePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<List<String>> rows = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        List<String> rowData =
            row.map((cell) => cell?.value.toString() ?? '').toList();
        rows.add(rowData);
      }
    }
    setState(() {
      _excelData = rows;
      _isLoading = false;
    });
  }

  Future<void> _exportFile() async {
    if (_filePath != null) {
      final directory = await getExternalStorageDirectory();
      final fileName = 'valorization_${widget.valorization.orderNumber}.xlsx';
      final filePath = '${directory!.path}/$fileName';
      final file = File(_filePath!);
      await file.copy(filePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo exportado en $filePath')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Excel'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('El archivo se ha convertido a Excel.'),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: _excelData.isNotEmpty
                            ? _excelData[0]
                                .map((col) => DataColumn(label: Text(col)))
                                .toList()
                            : [],
                        rows: _excelData.length > 1
                            ? _excelData
                                .sublist(1)
                                .map((row) => DataRow(
                                    cells: row
                                        .map((cell) => DataCell(Text(cell)))
                                        .toList()))
                                .toList()
                            : [],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _exportFile,
                  child: Text('Exportar'),
                ),
              ],
            ),
    );
  }
}
