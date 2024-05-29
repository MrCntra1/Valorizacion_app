import 'package:flutter/material.dart';
import 'dart:io';
import '../models/valorization.dart';
import '../services/excel_service.dart';

class DownloadExcelScreen extends StatefulWidget {
  final Valorization valorization;

  const DownloadExcelScreen({Key? key, required this.valorization})
      : super(key: key);

  @override
  _DownloadExcelScreenState createState() => _DownloadExcelScreenState();
}

class _DownloadExcelScreenState extends State<DownloadExcelScreen> {
  bool _isLoading = true;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _convertToExcel();
  }

  Future<void> _convertToExcel() async {
    final excelService = ExcelService();
    final filePath = await excelService.createExcel(widget.valorization);
    setState(() {
      _isLoading = false;
      _filePath = filePath;
    });
  }

  Future<void> _downloadFile() async {
    if (_filePath != null) {
      final file = File(_filePath!);
      if (await file.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo descargado en $_filePath')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar el archivo')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descargar Excel'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('El archivo se ha convertido a Excel.'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _downloadFile,
                  child: Text('Descargar'),
                ),
              ],
            ),
    );
  }
}
