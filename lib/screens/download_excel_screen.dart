import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
  late Future<int> storagePermissionChecker;

  @override
  void initState() {
    super.initState();
    storagePermissionChecker = checkStoragePermission();
  }

  Future<int> checkStoragePermission() async {
    if (await Permission.storage.isGranted) {
      _convertToExcel();
      return 1;
    } else {
      return await requestStoragePermission();
    }
  }

  Future<int> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      _convertToExcel();
      return 1;
    } else {
      setState(() {
        _isLoading = false;
      });
      return 0;
    }
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

  void _openAppSettings() async {
    bool opened = await openAppSettings();
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('No se pudo abrir la configuración del dispositivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descargar Excel'),
      ),
      body: FutureBuilder(
        future: storagePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return _isLoading
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
                      );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          storagePermissionChecker = requestStoragePermission();
                          setState(() {});
                        },
                        child: Text("Permitir permiso de almacenamiento"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _openAppSettings,
                        child: Text("Abrir configuración del dispositivo"),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child:
                    Text('Algo salió mal. Por favor, reinstala la aplicación.'),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
