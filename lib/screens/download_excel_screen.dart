import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadExcelScreen extends StatefulWidget {
  final String filePath;

  const DownloadExcelScreen({Key? key, required this.filePath})
      : super(key: key);

  @override
  _DownloadExcelScreenState createState() => _DownloadExcelScreenState();
}

class _DownloadExcelScreenState extends State<DownloadExcelScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndRequestStoragePermission();
  }

  Future<void> _checkAndRequestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      _downloadFile();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Permiso de almacenamiento denegado. Por favor, habilítalo en la configuración.'),
        ),
      );
    }
  }

  Future<void> _downloadFile() async {
    final directory = await getExternalStorageDirectory();
    final fileName = 'valorization_${widget.filePath.split('/').last}';
    final newFilePath = '${directory!.path}/$fileName';
    final file = File(widget.filePath);
    final newFile = await file.copy(newFilePath);

    if (await newFile.exists()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo descargado en $newFilePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar el archivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descargar Excel'),
      ),
      body: Center(
        child: CircularProgressIndicator(), // O usa SpinKit si prefieres
      ),
    );
  }
}
